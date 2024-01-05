import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RequestCreateController extends GetxController {
  var imagePicker = ImagePicker().obs;
  var image = XFile('').obs;
  var titleTextController = TextEditingController();
  var contentTextController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void reset() {
    titleTextController.clear();
    contentTextController.clear();
    image.value = XFile('');
    imagePicker.value = ImagePicker();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      XFile? pickedFile = await imagePicker.value.pickImage(source: source);
      if (pickedFile != null) {
        image.value = pickedFile;
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> fetchCreateRequestApi() async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = prefs!.getString('token')!;
      var url = Uri.parse(
          ApiEndPoints.baseURL + ApiEndPoints.requestEndPoints.createRequest);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['title'] = titleTextController.text;
      request.fields['description'] = contentTextController.text;
      final file = File(image.value.path);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      request.files.add(await http.MultipartFile.fromPath('image', file.path,
          filename: fileName));

      var response = await request.send();
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar(
          'Success',
          'Request has been created',
          snackPosition: SnackPosition.BOTTOM,
        );
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
