import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GroupListController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Group>> fetchGetAllGroupApi() async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.getAll + "1");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Group.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}