import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Login/login.index.dart';
import 'package:multiplatform_app/screens/Register/register.controller.dart';

class RegisterPage extends StatelessWidget {
  final registerController = Get.put(RegisterController());

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
                  'Sign up',
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
                  "Create an account, it's free",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: registerController.usernameTextController,
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
                  controller: registerController.emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  controller: registerController.phoneTextController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
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
                  controller: registerController.passwordTextController,
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
                SizedBox(height: 15,),
                TextField(
                  controller: registerController.rePasswordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                      registerController.fetchRegisterApi();
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                      child: Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                        onPressed: (){
                          Get.to(LoginPage());
                          },
                        child: Text('Login', style: TextStyle(color: Colors.blueAccent),)),
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
