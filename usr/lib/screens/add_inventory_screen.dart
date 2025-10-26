import 'package:flutter/material.dart';
import '../models/inventory_item.dart';

class AddInventoryScreen extends StatefulWidget {
  final Function(InventoryItem) onAdd;

  const AddInventoryScreen({super.key, required this.onAdd});

  @override
  State<AddInventoryScreen> createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Inventory Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final description = _descriptionController.text;
                final quantity = double.tryParse(_quantityController.text) ?? 0;
                final price = double.tryParse(_priceController.text) ?? 0;

                if (name.isNotEmpty && quantity > 0 && price > 0) {
                  final item = InventoryItem(
                    id: DateTime.now().toString(),
                    name: name,
                    description: description,
                    quantity: quantity,
                    price: price,
                  );
                  widget.onAdd(item);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}