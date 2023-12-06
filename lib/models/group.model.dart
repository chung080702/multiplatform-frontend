class Group {
  String id;
  String name;
  String description;
  late String imageURL;

  Group({required this.id, required this.name, required this.description});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json['_id'],
        name: json['name'],
        description: json['description']
    );
  }
}
