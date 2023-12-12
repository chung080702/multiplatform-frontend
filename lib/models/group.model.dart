class Group {
  String id;
  String name;
  String description;
  String imageID;
  int memberNumber;

  Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageID,
      required this.memberNumber});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        imageID: json['imageId'],
        memberNumber: json['memberNumber']);
  }
}
