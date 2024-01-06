class Group {
  final String id;
  final String name;
  final String description;
  final String imageId;
  final int memberNumber;

  const Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageId,
      required this.memberNumber});

  factory Group.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'name': String name,
        'description': String description,
        'imageId': String imageId,
        'memberNumber': int memberNumber
      } =>
        Group(
            id: id,
            name: name,
            description: description,
            imageId: imageId,
            memberNumber: memberNumber),
      _ => throw const FormatException('Failed to load Group.')
    };
  }
}
