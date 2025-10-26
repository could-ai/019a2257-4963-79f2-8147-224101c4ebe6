import 'package:flutter/material.dart';
import '../models/invoice.dart';
import '../models/invoice_item.dart';
import '../models/inventory_item.dart';

class CreateInvoiceScreen extends StatefulWidget {
  final List<InventoryItem> inventory;
  final Function(Invoice, List<InventoryItem>) onCreate;

  const CreateInvoiceScreen({
    super.key,
    required this.inventory,
    required this.onCreate,
  });

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final _customerController = TextEditingController();
  List<InvoiceItem> _selectedItems = [];
  List<InventoryItem> _currentInventory = [];

  @override
  void initState() {
    super.initState();
    _currentInventory = List.from(widget.inventory);
  }

  void _addItem(InventoryItem item, double quantity) {
    if (quantity > item.quantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient inventory')),
      );
      return;
    }

    setState(() {
      _selectedItems.add(InvoiceItem(
        inventoryItemId: item.id,
        itemName: item.name,
        quantity: quantity,
        price: item.price,
      ));
      item.quantity -= quantity;
    });
  }

  void _removeItem(int index) {
    setState(() {
      final item = _selectedItems[index];
      final inventoryItem = _currentInventory.firstWhere(
        (invItem) => invItem.id == item.inventoryItemId,
      );
      inventoryItem.quantity += item.quantity;
      _selectedItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _customerController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _currentInventory.length,
              itemBuilder: (context, index) {
                final item = _currentInventory[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Available: ${item.quantity}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final quantityController = TextEditingController();
                          return AlertDialog(
                            title: Text('Add ${item.name}'),
                            content: TextField(
                              controller: quantityController,
                              decoration: const InputDecoration(labelText: 'Quantity'),
                              keyboardType: TextInputType.number,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  final qty = double.tryParse(quantityController.text) ?? 0;
                                  if (qty > 0) {
                                    _addItem(item, qty);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Selected Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                ..._selectedItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return ListTile(
                    title: Text(item.itemName),
                    subtitle: Text('Qty: ${item.quantity} - Price: 
${item.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total: 
${item.total.toStringAsFixed(2)}'),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _removeItem(index),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(),
                Text(
                  'Invoice Total: 
${_selectedItems.fold(0.0, (sum, item) => sum + item.total).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final customer = _customerController.text;
          if (customer.isNotEmpty && _selectedItems.isNotEmpty) {
            final invoice = Invoice(
              id: DateTime.now().toString(),
              date: DateTime.now(),
              customerName: customer,
              items: _selectedItems,
            );
            widget.onCreate(invoice, _currentInventory);
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter customer name and select items')),
            );
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    _customerController.dispose();
    super.dispose();
  }
}