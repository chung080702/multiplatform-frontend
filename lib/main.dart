import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/contants/app_font.dart';
import 'package:multiplatform_app/general/routes/routes.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thiện nguyện",
      onGenerateRoute: Routes.onGeneralRoute,
      theme: ThemeData(fontFamily: AppFont.helveticaNeue),
    );
  }
}
