import 'package:multiplatform_app/models/user.model.dart';

class JoinGroupRequest {
  String id;
  User user;
  String status;
  String groupId;

  JoinGroupRequest(
      {required this.id,
      required this.user,
      required this.status,
      required this.groupId});

  factory JoinGroupRequest.fromJson(Map<String, dynamic> json) {
    User tmpUser = User.fromJson(json['accountId']);
    return JoinGroupRequest(
        id: json['_id'],
        user: tmpUser,
        status: json['status'],
        groupId: json['groupId']);
  }
}
