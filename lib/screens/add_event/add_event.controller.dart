import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEventController {
  Future<bool> createEvent(
      String groupId,
      String name,
      String desc,
      String startTime,
      String endTime,
      String address,
      String content,
      String? supportRequestId,
      List<File> images) async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.groupEndPoints.createEvent(groupId));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      var request = http.MultipartRequest("POST", url);
      request.headers["Authorization"] = token ?? "";
      request.headers["Content-Type"] = 'multipart/form-data';
      request.fields["name"] = name;
      request.fields["start"] = startTime;
      request.fields["end"] = endTime;
      request.fields["address"] = address;
      request.fields["description"] = desc;
      request.fields["content"] = content;
      if (supportRequestId != null) {
        request.fields[supportRequestId] = supportRequestId;
      }
      await Future.forEach(images, (image) async {
        request.files.add(http.MultipartFile("image",
            (http.ByteStream(image.openRead().cast())), await image.length(),
            filename: basename(image.path)));
      });
      var response = await request.send();
      print(
          "${DateTime.now()}-AddEventController-createEvent-response:${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      print(
          "${DateTime.now()}-AddEventController-createEvent-error:${e.toString()}");
      return false;
    }
  }

  Future<List<Request>> getRequests(int page) async {
    try {
      var url = Uri.parse(
          ApiEndPoints.baseURL + ApiEndPoints.requestEndPoints.getAll(page));
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonRequests = data['supportRequests'];
        List<Request> requests =
            jsonRequests.map((item) => Request.fromJson(item)).toList();
        return requests;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
