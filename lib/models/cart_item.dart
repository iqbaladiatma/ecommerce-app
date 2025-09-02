class CartItem {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    double? price,
    String? imageUrl,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      title: json['title'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }
}
