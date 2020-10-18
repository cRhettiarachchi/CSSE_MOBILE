class Supplier {
  final String id;
  final String name;

  Supplier({this.id, this.name});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return new Supplier(id: json['_id'], name: json['name']);
  }
}
