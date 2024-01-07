import 'dart:convert';

import 'package:multiplatform_app/general_controller/account.controller.dart';
import 'package:multiplatform_app/models/user.model.dart';
import 'package:multiplatform_app/screens/Admin/admin.index.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final accountController = Get.put(AccountController());
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> fetchLoginApi() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.authEndPoints.login);
      Map body = {
        'username': usernameTextController.text,
        'password': passwordTextController.text,
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        String token = responseData['token'];
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString("token", token);
        accountController.account.value =
            User.fromJson(responseData['account']);
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
        );
        if (usernameTextController.text == "admin" && passwordTextController.text == "admin") {
          Get.offAll(AdminPage(index: 0,));
        } else {
          Get.offAll(App());
        }
        usernameTextController.clear();
        passwordTextController.clear();
      } else {
        throw response.body ?? "Unknown Error Occured";
      }
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
