class Review {
  final String id;
  final String seller;
  final String customer;
  final String comment;
  final double point;

  Review({this.id, this.seller, this.customer, this.comment, this.point});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] as String,
      seller: json['seller'] as String,
      customer: json['customer'] as String,
      comment: json['comment'] as String,
      point: json['point'] as double,
    );
  }
}
