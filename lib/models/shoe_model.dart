class Product {
  final String id;
  final String name;
  final String model;
  final double price;
  final String imgAddress;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.model,
    required this.price,
    required this.imgAddress,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? "Unknown",
      model: json['model'] ?? "Unknown",
      price:
          double.tryParse(json['price'].toString()) ?? 0.0, // Safe conversion
      imgAddress:
          "http://192.168.0.102/shoe_hive_db/product_images/${json['imgAddress']}",
    );
  }
}
