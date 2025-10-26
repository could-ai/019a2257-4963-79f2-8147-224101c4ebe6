import 'invoice_item.dart';

class Invoice {
  final String id;
  final DateTime date;
  final String customerName;
  final List<InvoiceItem> items;

  Invoice({
    required this.id,
    required this.date,
    required this.customerName,
    required this.items,
  });

  double get total => items.fold(0, (sum, item) => sum + item.total);
}