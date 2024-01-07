import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/group.model.dart';
import '../../utils/api_endpoint.dart';

Future<List<Group>> fetchGroup() async {
  final response = await http
      .get(Uri.parse('https://multiplatform-backend.vercel.app/group/page/1'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['groups'];
    return jsonResponse.map((group) => Group.fromJson(group)).toList();
  } else {
    throw Exception('Failed to load Group');
  }
}

Future<bool> fetchCreateGroup(
    String groupName, String groupDesc, File bgImage) async {
  try {
    var url =
        Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.create);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    var request = http.MultipartRequest("POST", url);
    request.headers["Authorization"] = token ?? "";
    request.headers["Content-Type"] = 'multipart/form-data';
    request.fields["name"] = groupName;
    request.fields["description"] = groupDesc;
    request.files.add(http.MultipartFile("image",
        (http.ByteStream(bgImage.openRead().cast())), await bgImage.length(),
        filename: basename(bgImage.path)));
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  } catch (e) {
    print(
        "${DateTime.now()}-GroupController-createGroup-error:${e.toString()}");
    return false;
  }
}
