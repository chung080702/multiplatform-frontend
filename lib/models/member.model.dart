import 'package:multiplatform_app/models/user.model.dart';

class Member {
  String id;
  User user;
  String role;

  Member({required this.id, required this.user, required this.role});

  factory Member.fromJson(Map<String, dynamic> json) {
    User tmpUser = User.fromJson(json['accountId']);
    return Member(id: json['_id'], user: tmpUser, role: json['role']);
  }
}