class Item {
  final String id;
  final String name;

  Item({this.id, this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    return new Item(id: json['_id'], name: json['name']);
  }
}
