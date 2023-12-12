import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/screens/Register/register.index.dart';

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
      home: RegisterPage(),
    );
  }
}
