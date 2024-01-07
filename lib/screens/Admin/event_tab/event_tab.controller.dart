import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/screens/Admin/admin.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EventTabController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Event>> fetchGetAllEventPendingApi() async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.eventEndPoints.getAllPending(1));
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonEvents = data['events'];
        List<Event> events = jsonEvents.map((item) => Event.fromJson(item)).toList();
        return events;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }

  Future<void> fetchAcceptEventAPI(String eventID) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {"Authorization": token};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.eventEndPoints.acceptEvent(eventID));
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        Get.offAll(AdminPage(index: 0));
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('Sự kiện đã được duyệt')],
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

  Future<void> fetchRejectEventAPI(String eventID) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {"Authorization": token};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.eventEndPoints.rejectEvent(eventID));
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        Get.offAll(AdminPage(index: 0));
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('Sự kiện đã bị từ chối')],
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