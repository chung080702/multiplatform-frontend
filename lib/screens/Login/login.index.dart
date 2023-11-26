import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/routes/routes.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Text("login page"),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.home);
        },
        child: SizedBox(
          width: 50,
          height: 50,
          child: Container(decoration: BoxDecoration(color: Colors.black)),
        ),
      ),
    );
  }
}
