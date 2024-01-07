import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/models/suport_request.model.dart';
import 'package:multiplatform_app/models/user.model.dart';

class PersonalContributeModel {
  PersonalContributeModel(
      {required this.id,
      required this.user,
      required this.supportRequest,
      required this.imageIds,
      required this.status});

  String id;
  User user;
  SupportRequestModel supportRequest;
  List<String> imageIds;
  String status;

  factory PersonalContributeModel.fromJson(Map<String, dynamic> json) =>
      PersonalContributeModel(
          id: json["_id"],
          user: User.fromJson(json["accountId"]),
          supportRequest:
              SupportRequestModel.fromJson(json["supportRequestId"]),
          imageIds: List<String>.from(json["imageIds"]),
          status: json["status"]);
}
