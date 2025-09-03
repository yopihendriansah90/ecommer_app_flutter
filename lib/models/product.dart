class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // mengonversi nilai dari Json dengan penangan fleksibel untuk harga
    final price = json['price'] as num;

    return Product(
      id: json['id'] as int,
      name: json['title'] as String,
      price: price.toDouble(),
      imageUrl: json['image'] as String,
    );
  }
}
