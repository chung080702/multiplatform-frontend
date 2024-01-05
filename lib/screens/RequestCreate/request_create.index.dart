import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/screens/RequestCreate/request_create.controller.dart';
import 'package:multiplatform_app/utils/color.dart';

class RequestCreate extends StatefulWidget {
  @override
  State<RequestCreate> createState() => _RequestCreateState();
}

class _RequestCreateState extends State<RequestCreate> {
  bool isLoading = false;
  final requestCreateController = Get.put(RequestCreateController());

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.offAll(ProfilePage());
                  requestCreateController.reset();
                },
              ),
              title: Text('Tạo yêu cầu trợ giúp'),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await requestCreateController.fetchCreateRequestApi();
                      requestCreateController.reset();
                    },
                    child: Text(
                      'Thêm',
                      style: TextStyle(
                        color: backgroundGradientFirst,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              child: Obx(
                () => Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: requestCreateController.titleTextController,
                        decoration: InputDecoration(
                          hintText: 'Tiêu đề',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller:
                            requestCreateController.contentTextController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Nội dung',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      requestCreateController.image.value.path.isEmpty
                          ? Text(
                              'No image selected.',
                              style: TextStyle(color: Colors.black),
                            )
                          : Image.file(
                              File(requestCreateController.image.value.path),
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () => requestCreateController
                            .pickImage(ImageSource.gallery),
                        child: Text('Chọn ảnh từ thư viện'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
