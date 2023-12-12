import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/screens/RequestCreate/request_create.controller.dart';
import 'package:multiplatform_app/utils/color.dart';

class RequestCreate extends StatelessWidget {
  final requestCreateController = Get.put(RequestCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo yêu cầu trợ giúp'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                requestCreateController.fetchCreateRequestApi();
              },
              child: Text('Thêm', style: TextStyle(
                color: backgroundGradientFirst,
                fontWeight: FontWeight.w600,
              ),),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Get.offAll(HomePage());
            }
            else if (index == 2) {
              Get.offAll(ProfilePage());
            }
          },
          currentIndex: 2,
          selectedItemColor: backgroundGradientFirst,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: requestCreateController.titleTextController,
              decoration: InputDecoration(
                hintText: 'Tiêu đề',
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: requestCreateController.contentTextController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Nội dung',

              ),
            )
          ],
        ),
      ),
    );
  }
}
