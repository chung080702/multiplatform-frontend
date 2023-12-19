import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Group/group.list.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/utils/color.dart';
import 'package:multiplatform_app/widgets/event_card_list/event_card_list.index.dart';
import 'package:multiplatform_app/widgets/group_card_list/group_card_list.index.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Get.to(Groups());
            }
            else if (index == 2) {
              Get.to(ProfilePage());
            }
          },
          currentIndex: 0,
          selectedItemColor: backgroundGradientFirst,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group), label: 'Group'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                backgroundGradientFirst,
                backgroundGradientSecond,
              ],
            )
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(Icons.search)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Các hội nhóm thiện nguyện", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              GroupCardList(info: {
                'type': 'all',
              },),
              SizedBox(height: 20,),
              Text("Các sự kiện sắp diễn ra", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              EventCardList(info: {
                'type': 'all',
              }),
            ],
          ),
        ),
      ),
    );
  }
}
