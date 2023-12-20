import 'dart:convert';

import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/account.controller.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GroupListController extends GetxController {
  final accountController = Get.find<AccountController>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Group>> fetchGetAllGroupApi() async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      Map<String, String> headers = {
        'Authorization': token,
      };
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.getAll + "1");
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonGroups = data['groups'];
        List<Group> groups = jsonGroups.map((item) => Group.fromJson(item)).toList();
        return groups;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Group>> fetchGetAllOfUserApi() async {
    try {
      var accountID = accountController.account.value?.id;
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.getAllOfUser(accountID!, 1));
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonGroups = data['groups'];
        List<Group> groups = jsonGroups.map((item) => Group.fromJson(item['groupId'])).toList();
        return groups;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }
}