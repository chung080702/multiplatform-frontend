import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/routes/base_page_route.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/screens/add_event/add_event.index.dart';
import 'package:multiplatform_app/screens/detail_event/detail_event.index.dart';
import 'package:multiplatform_app/screens/view_event/view_event.index.dart';

class Routes {
  static const String addEvent = "addEvent";
  static const String eventList = 'eventList';
  static const String eventDetail = 'eventDetail';

  static Route<dynamic> onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case addEvent:
        return BasePageRoute(
            child: const AddEvent(
          groupId: "hghgh",
        ));
      case eventList:
        return BasePageRoute(child: const ViewEvent());
      case eventDetail:
        final Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return BasePageRoute(
            child: DetailEvent(
          hrefs: args["hrefs"]!,
          name: args["name"]!,
          desc: args["desc"]!,
          startTime: args["startTime"]!,
          endTime: args["endTime"]!,
          address: args["address"]!,
          content: args["content"]!,
        ));
      default:
        return BasePageRoute(
            child: const Scaffold(
          body: Text("Page is not found"),
        ));
    }
  }
}
