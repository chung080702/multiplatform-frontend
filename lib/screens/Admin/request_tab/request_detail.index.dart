import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/Admin/admin.index.dart';
import 'package:multiplatform_app/screens/Admin/request_tab/request_tab.controller.dart';
import 'package:multiplatform_app/screens/direct_support/direct_support.index.dart';
import 'package:multiplatform_app/screens/personal_contribute/personal_contribute.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class DetailRequest extends StatelessWidget {
  final requestTabController = Get.put(RequestTabController());
  Request request;
  DetailRequest({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu cầu trợ giúp'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await requestTabController.fetchAcceptRequestAPI(request.id);
            },
          child: Text('Chấp nhận', style: TextStyle(color: Colors.green))),
          TextButton(
              onPressed: () async {
                await requestTabController.fetchRejectRequestAPI(request.id);
              },
              child: Text('Từ chối', style: TextStyle(color: Colors.red)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.network(
                  ApiEndPoints.baseURL +
                      ApiEndPoints.fileEndPoints.getFile +
                      request.image,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  request.title,
                  style: AppTextStyle.textStyle_24_600_36,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Thông tin liên hệ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'SĐT: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        request.phone,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(request.email, style: TextStyle(fontSize: 18)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Nội dung',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                request.description,
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
