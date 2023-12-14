class Group {
  final String name;
  final String description;
  final String imageId;
  final int memberNumber;

  const Group({
    required this.name,
    required this.description,
    required this.imageId,
    required this.memberNumber
  });

  factory Group.fromJson(Map<String, dynamic> json){
    return switch (json) {
      {
        'name': String name,
        'description': String description,
        'imageId': String imageId,
        'memberNumber': int memberNumber
      } =>
        Group(
          name: name,
          description: description,
          imageId: imageId,
          memberNumber: memberNumber
        ),
      _ => throw const FormatException('Failed to load Group.')
    };
  }
}