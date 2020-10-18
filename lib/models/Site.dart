class Site {
  final String id;
  final String name;

  Site({this.id, this.name});

  factory Site.fromJson(Map<String, dynamic> json) {
    return new Site(id: json['_id'], name: json['name']);
  }
}
