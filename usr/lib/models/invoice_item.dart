import 'inventory_item.dart';

class InvoiceItem {
  final String inventoryItemId;
  final String itemName;
  final double quantity;
  final double price;

  InvoiceItem({
    required this.inventoryItemId,
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}