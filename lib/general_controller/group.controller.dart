import 'dart:convert';

import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/account.controller.dart';
import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/models/join_group_request.model.dart';
import 'package:multiplatform_app/models/member.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GroupController extends GetxController {
  final accountController = Get.find<AccountController>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  // gui yeu cau tham gia nhom
  Future<bool> fetchJoinGroupAPI(int groupID) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {
        "Authorization": token,
        'Content-Type': 'application/json'
      };
      var url = Uri.parse(
        ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.joinGroup(groupID)
      );
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // lay danh sach yeu cau tham gia
  Future<List<JoinGroupRequest>> fetchGetAllJoinGroupRequestAPI(String groupID, int page) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {
        "Authorization": token,
      };
      var url = Uri.parse(
        ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.getAllJoinGroupRequest(groupID, page)
      );
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonJoinRequests = data['joinRequests'];
        List<JoinGroupRequest> joinGroupRequests = jsonJoinRequests.map((json) => JoinGroupRequest.fromJson(json)).toList();
        return joinGroupRequests;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // chap nhan yeu cau tham gia nhom
  Future<bool> fetchAcceptJoinGroupRequestAPI(String groupID, String joinRequestID) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token,
      };
      var url = Uri.parse(
        ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.acceptJoinGroupRequest(groupID, joinRequestID)
      );
      var response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> fetchRejectJoinGroupRequestAPI(String groupID, String joinRequestID) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token,
      };
      var url = Uri.parse(
          ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.rejectJoinGroupRequest(groupID, joinRequestID)
      );
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // lay danh sach su kien trong nhom
  Future<List<Event>> fetchGetAllEventOfGroupAPI(String groupID, int page) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {
        "Authorization": token
      };
      var url = Uri.parse(
        ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.getEventsOfGroup(groupID, page)
      );
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonEvents = data['events'];
        List<Event> events = jsonEvents.map((json) => Event.fromJson(json)).toList();
        return events;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }


  // lay danh sach thanh vien nhom
  Future<List<Member>> fetchGetAllMemberOfGroupAPI(String groupID, int page) async {
    try {
      var url = Uri.parse(
        ApiEndPoints.baseURL + ApiEndPoints.groupEndPoints.getMembersOfGroup(groupID, page)
      );
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonMembers = data['members'];
        List<Member> members = jsonMembers.map((json) => Member.fromJson(json)).toList();
        return members;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}