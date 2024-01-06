import 'dart:convert';

import 'package:multiplatform_app/models/event.model.dart';
import 'package:http/http.dart' as http;
import 'package:multiplatform_app/utils/api_endpoint.dart';

class ViewEventController {
  Future<List<Event>> getEvents(int page, String? filter) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseURL +
          ApiEndPoints.eventEndPoints.getAll(page, filter));
      var response = await http.get(
        url,
        headers: headers,
      );
      print(
          "${DateTime.now()}-ViewEventController-ViewEventController-response:$response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Event> events =
            List.from(jsonDecode(response.body)["events"])
                .map((e) => Event.fromJson(e))
                .toList();
        return events;
      }
      return [];
    } catch (e) {
      print(
          "${DateTime.now()}-ViewEventController-ViewEventController-error:${e.toString()}");
      return [];
    }
  }
}
