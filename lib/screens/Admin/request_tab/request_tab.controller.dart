import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/Admin/admin.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RequestTabController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Request>> fetchGetAllRequestPendingApi(int page) async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints.getAllPending(page));
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

  Future<void> fetchAcceptRequestAPI(String requestID) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {"Authorization": token};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints.acceptRequest(requestID));
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        Get.offAll(AdminPage(index: 1));
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('Yêu cầu đã được duyệt')],
              );
            });
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Error'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('Có lỗi, vui lòng thử lại')],
              );
            });
      }
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('Có lỗi, vui lòng thử lại')],
            );
          });
    }
  }

  Future<void> fetchRejectRequestAPI(String requestID) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {"Authorization": token};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.requestEndPoints.rejectRequest(requestID));
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        Get.offAll(AdminPage(index: 1));
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('Yêu cầu đã bị từ chối')],
              );
            });
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Error'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('Có lỗi, vui lòng thử lại')],
              );
            });
      }
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('Có lỗi, vui lòng thử lại')],
            );
          });
    }
  }
}
