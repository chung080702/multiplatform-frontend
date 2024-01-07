import 'dart:convert';

import 'package:multiplatform_app/models/personal_contribute.model.dart';
import 'package:multiplatform_app/models/user.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PersonalContributeController {
  Future<List<PersonalContributeModel>> getUsersBySupportRequest(
      String supportRequestId, int page) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints
              .getPersonalsContribute(supportRequestId, page));
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token ?? ""
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<PersonalContributeModel> personalContributes =
            List.from(jsonDecode(response.body)["groupContributes"])
                .map((item) => PersonalContributeModel.fromJson(item))
                .toList();
        return personalContributes;
      }
      return [];
    } catch (e) {
      print(
          "${DateTime.now()}-PersonalContributeController-getUsersBySupportRequest-error:${e.toString()}");
      return [];
    }
  }

  Future<bool> acceptPersonalContribute(String personalContributeId) async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints
              .acceptPersonalContribute(personalContributeId));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token ?? ""
      };
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectPersonalContribute(String personalContributeId) async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints
              .rejectPersonalContribute(personalContributeId));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token ?? ""
      };
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
