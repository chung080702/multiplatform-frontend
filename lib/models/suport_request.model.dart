class SupportRequestModel {
  SupportRequestModel(
      {required this.id,
      required this.accountId,
      required this.title,
      required this.description,
      required this.imageIds,
      required this.status});

  String id;
  String accountId;
  String title;
  String description;
  List<String> imageIds;
  String status;

  factory SupportRequestModel.fromJson(Map<String, dynamic> json) =>
      SupportRequestModel(
          id: json["_id"],
          accountId: json["accountId"],
          title: json["title"],
          description: json["description"],
          imageIds: List<String>.from(json["imageIds"]),
          status: json["status"]);
}
