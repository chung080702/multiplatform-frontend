import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/routes/base_page_route.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';

class Routes {
  static const String home = 'home';
  static const String login = 'login';
  static Route<dynamic> onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return BasePageRoute(child: HomePage());
      default:
        return BasePageRoute(
            child: const Scaffold(
          body: Text("Page is not found"),
        ));
    }
  }
}
