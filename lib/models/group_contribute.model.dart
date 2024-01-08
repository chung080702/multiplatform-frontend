import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/models/user.model.dart';

class GroupContribute {
  String id;
  Event event;
  User user;

  GroupContribute({required this.id, required this.event, required this.user});
  
  factory GroupContribute.fromJson(Map<String, dynamic> json) {
    return GroupContribute(id: json["_id"], event: Event.fromJson(json['eventId']), user: User.fromJson(json['accountId']));
  }

}