class Order {
  final String id;
  final String seller;
  final String date;
  final String customer;
  final String customerName;
  final dynamic totalPrice;
  final List<dynamic> products;

  Order({
    this.id,
    this.seller,
    this.date,
    this.customer,
    this.customerName,
    this.totalPrice,
    this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] as String,
      seller: json['seller'] as String,
      date: json['date'] as String,
      customer: json['customer'] as String,
      customerName: json['customerName'] as String,
      totalPrice: json['totalPrice'] as dynamic,
      products: json['products'] as List,
    );
  }
}
