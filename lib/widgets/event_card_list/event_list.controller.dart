import 'package:get/get.dart';
import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventListController extends GetxController {
  Future<List<Event>> fetchGetAllEventApi() async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.eventEndPoints.getAll(1));
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
}