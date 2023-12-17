import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:path/path.dart';

class AddEventController {
  Future<bool> createEvent(
      String groupId,
      String name,
      String desc,
      String startTime,
      String endTime,
      String address,
      String content,
      List<File> images) async {
    try {
      var headers = {'Content-Type': 'multipart/form-data;'};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.groupEndPoints.createEvent(groupId));
      final body = {
        "name": name,
        "start": startTime,
        "end": endTime,
        "address": address,
        "description": desc,
        "content": content,
        "image": images
      };
      var request = http.MultipartRequest("POST", url);
      request.fields["name"] = name;
      request.fields["start"] = startTime;
      request.fields["end"] = endTime;
      request.fields["address"] = address;
      request.fields["description"] = desc;
      request.fields["content"] = content;
      await Future.forEach(images, (image) async {
        request.files.add(http.MultipartFile("image",
            (http.ByteStream(image.openRead().cast())), await image.length(),
            filename: basename(image.path)));
      });
      var response = await request.send();
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
}
