import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Login/login.controller.dart';
import 'package:multiplatform_app/screens/Register/register.index.dart';

class LoginPage extends StatelessWidget {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 35),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Login to your account",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: loginController.usernameTextController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: loginController.passwordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: (){
                    loginController.fetchLoginApi();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                    child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: (){
                          Get.to(RegisterPage());
                        },
                        child: Text('Sign up', style: TextStyle(color: Colors.blueAccent),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
