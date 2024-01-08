import 'package:get/get.dart';
import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Event>> fetchNotJoinEventsAPI(
      String eventID, int page) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {"Authorization": token};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.eventEndPoints.getNotJoinEvents(eventID, 1));
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonEvents = data['events'];
        List<Event> events =
        jsonEvents.map((json) => Event.fromJson(json)).toList();
        return events;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Event>> fetchPendingJoinEventsAPI(
      String eventID, int page) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {"Authorization": token};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.eventEndPoints.getPendingJoinEvents(eventID, 1));
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonEvents = data['events'];
        List<Event> events =
        jsonEvents.map((json) => Event.fromJson(json)).toList();
        return events;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Event>> fetchAcceptedJoinEventsAPI(
      String eventID, int page) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String token = await prefs!.getString('token')!;
      var headers = {"Authorization": token};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.eventEndPoints.getAcceptedJoinEvents(eventID, 1));
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonEvents = data['events'];
        List<Event> events =
        jsonEvents.map((json) => Event.fromJson(json)).toList();
        return events;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

}