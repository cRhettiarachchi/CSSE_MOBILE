class Order {
  final String id;
  final String date;
  final int total;

  Order({this.id, this.date, this.total});

  factory Order.fromJson(Map<String, dynamic> json) {
    return new Order(
      id: json['_id'],
      date: json['date'],
      total: json['total'],
    );
  }
}
