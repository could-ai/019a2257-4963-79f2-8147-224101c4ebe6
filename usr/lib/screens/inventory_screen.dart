import 'package:flutter/material.dart';
import '../models/inventory_item.dart';
import 'add_inventory_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<InventoryItem> _inventory = [
    InventoryItem(id: '1', name: 'Item 1', description: 'Description 1', quantity: 10, price: 5.0),
    InventoryItem(id: '2', name: 'Item 2', description: 'Description 2', quantity: 5, price: 10.0),
  ];

  void _addItem(InventoryItem item) {
    setState(() {
      _inventory.add(item);
    });
  }

  void _updateQuantity(String id, double newQuantity) {
    setState(() {
      final item = _inventory.firstWhere((item) => item.id == id);
      item.quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: ListView.builder(
        itemCount: _inventory.length,
        itemBuilder: (context, index) {
          final item = _inventory[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('${item.description} - Qty: ${item.quantity} - Price: 
${item.price}'),
            trailing: Text('Total: ${(item.quantity * item.price).toStringAsFixed(2)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddInventoryScreen(onAdd: _addItem),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}