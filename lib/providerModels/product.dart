class Product {
  final String seller;
  final String name;
  final String imagePath;
  final String category;
  final double price;
  final String description;
  final bool isWeight;
  final int sold;

  Product(
      {this.seller,
      this.name,
      this.imagePath,
      this.category,
      this.price,
      this.description,
      this.isWeight,
      this.sold});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        seller: json['seller'] as String,
        name: json['name'] as String,
        imagePath: json['imagePath'] as String,
        category: json['category'] as String,
        price: json['price'] as double,
        description: json['description'] as String,
        isWeight: json['isWeight'] as bool,
        sold: json['sold'] as int);
  }
}
