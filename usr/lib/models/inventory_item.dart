class InventoryItem {
  final String id;
  final String name;
  final String description;
  double quantity;
  final double price;

  InventoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
    };
  }

  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}