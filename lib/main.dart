import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/screens/Register/register.index.dart';
import 'package:multiplatform_app/screens/add_event/add_event.index.dart';
import 'package:multiplatform_app/screens/view_event/view_event.index.dart';
import 'package:multiplatform_app/general/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AddEvent(),
      onGenerateRoute: Routes.onGeneralRoute,
    );
  }
}
