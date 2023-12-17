class Event {
  String id;
  String groupId;
  String name;
  String start;
  String end;
  String address;
  String description;
  String content;
  List<String> imageIds;
  String status;

  Event(
      {required this.id,
        required this.groupId,
      required this.name,
      required this.start,
      required this.end,
      required this.address,
      required this.description,
      required this.content,
      required this.imageIds,
      required this.status});

  factory Event.fromJson(Map<String, dynamic> json) {
    // DateTime start = DateTime.parse(json['start']);
    // DateTime end = DateTime.parse(json['end']);
    return Event(
        id: json['_id'],
        name: json['name'],
        groupId: json['groupId'],
        start: json['start'],
        end: json['end'],
        address: json['address'],
        description: json['description'],
        content: json['content'],
        imageIds: List<String>.from(json['imageIds']),
        status: json['status']);
  }
}
