import 'package:get/get.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RequestCreateController extends GetxController {
  var titleTextController = TextEditingController();
  var contentTextController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> fetchCreateRequestApi() async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = prefs!.getString('token')!;
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.requestEndPoints.createRequest);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['title'] = titleTextController.text;
      request.fields['destination'] = contentTextController.text;

      var response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Request has been created',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAll(ProfilePage());
      } else {
        throw response;
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