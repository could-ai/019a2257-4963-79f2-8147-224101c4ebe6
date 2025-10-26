import 'package:flutter/material.dart';
import '../models/invoice.dart';
import '../models/inventory_item.dart';
import 'create_invoice_screen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  List<Invoice> _invoices = [];
  List<InventoryItem> _inventory = [
    InventoryItem(id: '1', name: 'Item 1', description: 'Description 1', quantity: 10, price: 5.0),
    InventoryItem(id: '2', name: 'Item 2', description: 'Description 2', quantity: 5, price: 10.0),
  ];

  void _addInvoice(Invoice invoice, List<InventoryItem> updatedInventory) {
    setState(() {
      _invoices.add(invoice);
      _inventory = updatedInventory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return ListTile(
            title: Text('Invoice ${invoice.id}'),
            subtitle: Text('${invoice.customerName} - ${invoice.date.toString().split(' ')[0]}'),
            trailing: Text('Total: ' + '${invoice.total.toStringAsFixed(2)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateInvoiceScreen(
                inventory: _inventory,
                onCreate: _addInvoice,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}