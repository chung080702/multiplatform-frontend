import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/models/membership.model.dart';

class Group {
  final String id;
  final String name;
  final String description;
  final String imageId;
  final int memberNumber;
  final Membership membership;
  List<Event> events = [];

  Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageId,
      required this.memberNumber,
      required this.membership});

  factory Group.fromJson(Map<String, dynamic> json) {
    Membership membership = Membership(
        id: "None", accountId: "None", groupId: "None", status: "None");
    List<dynamic> membershipJson = json['membership'];
    List<Membership> membershipList =
        membershipJson.map((e) => Membership.fromJson(e)).toList();
    if (membershipList.isNotEmpty) {
      membership = membershipList[0];
    }
    return Group(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        imageId: json['imageId'],
        memberNumber: json['memberNumber'],
        membership: membership);
  }
}
