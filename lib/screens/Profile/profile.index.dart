import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/account.controller.dart';
import 'package:multiplatform_app/screens/Group/group.list.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/screens/Login/login.index.dart';
import 'package:multiplatform_app/screens/RequestCreate/request_create.index.dart';
import 'package:multiplatform_app/utils/color.dart';
import 'package:multiplatform_app/widgets/event_card_list/event_card_list.index.dart';
import 'package:multiplatform_app/widgets/group_card.index.dart';
import 'package:multiplatform_app/widgets/group_card_list/group_card_list.index.dart';
import 'package:multiplatform_app/widgets/request_card_list/request_card_list.index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final accountController = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int item) async {
      switch (item) {
        case 0:
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          Get.offAll(LoginPage());
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Đăng xuất'),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.account_circle,
              size: 100,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(50),
                //   border: Border.all(color: Colors.black, width: 1),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${accountController.account.value?.id}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(RequestCreate());
                        },
                        child: Text('Thêm yêu cầu trợ giúp')),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nhóm của bạn',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    GroupCardList(
                      info: {
                        'type': 'ofUser',
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Yêu cầu trợ giúp của bạn',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    RequestCardList(
                      info: {
                        'type': 'ofUser',
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
