import 'dart:convert';

import 'package:multiplatform_app/screens/Login/login.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final rePasswordTextController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> fetchRegisterApi() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.authEndPoints.register);
      Map body = {
        "username": usernameTextController.text,
        "email": emailTextController.text,
        "telephone": phoneTextController.text,
        "password": passwordTextController.text,
        "rePassword": rePasswordTextController.text,
      };
      
      var response = await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Registration successful!',
          snackPosition: SnackPosition.BOTTOM,
        );
        usernameTextController.clear();
        emailTextController.clear();
        phoneTextController.clear();
        passwordTextController.clear();
        rePasswordTextController.clear();
        Get.to(LoginPage());
      } else {
        throw response.body ?? "Unknown Error Occured";
      }
    } catch (e) {
      showDialog(context: Get.context!, builder: (context) {
        return SimpleDialog(
          title: Text('Error'),
          contentPadding: EdgeInsets.all(20),
          children: [Text(e.toString())],
        );
      });
    }
  }

}