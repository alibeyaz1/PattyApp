class Order {
  final String id;
  final String seller;
  final String sellerName;
  final String date;
  final String customer;
  final String customerName;
  final String address;
  final dynamic totalPrice;
  final List<dynamic> products;

  Order({
    this.id,
    this.seller,
    this.sellerName,
    this.date,
    this.customer,
    this.customerName,
    this.address,
    this.totalPrice,
    this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] as String,
      seller: json['seller'] as String,
      sellerName: json['sellerName'] as String,
      date: json['date'] as String,
      customer: json['customer'] as String,
      customerName: json['customerName'] as String,
      address: json['address'] as String,
      totalPrice: json['totalPrice'] as dynamic,
      products: json['products'] as List,
    );
  }
}
