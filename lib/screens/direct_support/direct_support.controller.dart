import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DirectSupportController {
  Future<bool> createPersonalContribute(
      List<File> images, supportRequestId) async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints
              .createPersonalContribute(supportRequestId));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      var request = http.MultipartRequest("POST", url);
      request.headers["Authorization"] = token ?? "";
      request.headers["Content-Type"] = 'multipart/form-data';
      await Future.forEach(images, (image) async {
        request.files.add(http.MultipartFile("image",
            (http.ByteStream(image.openRead().cast())), await image.length(),
            filename: basename(image.path)));
      });
      var response = await request.send();
      print(
          "${DateTime.now()}-DirectSupportController-createPersonalContribute-response:${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Error'),
                contentPadding: const EdgeInsets.all(20),
                children: [Text("${response.reasonPhrase}")],
              );
            });
      }
      return false;
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
      print(
          "${DateTime.now()}-DirectSupportController-createPersonalContribute-error:${e.toString()}");
      return false;
    }
  }
}
