import 'dart:convert';

import 'package:multiplatform_app/models/user.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:http/http.dart' as http;

class PersonalContributeController {
  Future<List<User>> getUsersBySupportRequest(
      String supportRequestId, int page) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints
              .getPersonalsContribute(supportRequestId, page));
      var response = await http.get(
        url,
        headers: headers,
      );
      print(
          "${DateTime.now()}-PersonalContributeController-getUsersBySupportRequest-response:$response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<User> users =
            List.from(jsonDecode(response.body)["groupContributes"])
                .map((item) => User.fromJson(item["accountId"]))
                .toList();
        return users;
      }
      return [];
    } catch (e) {
      print(
          "${DateTime.now()}-PersonalContributeController-getUsersBySupportRequest-error:${e.toString()}");
      return [];
    }
  }
}
