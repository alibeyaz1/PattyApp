class Order {
  final String id;
  final String seller;
  final String customer;
  final double totalPrice;
  final List<String> products;

  Order({
    this.id,
    this.seller,
    this.customer,
    this.totalPrice,
    this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] as String,
      seller: json['seller'] as String,
      customer: json['customer'] as String,
      totalPrice: json['totalPrice'] as double,
      products: json['products'] as List,
    );
  }
}
