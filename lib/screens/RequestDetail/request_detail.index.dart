import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:multiplatform_app/utils/color.dart';

class RequestDetail extends StatelessWidget {
  Request request;

  RequestDetail({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yêu cầu trợ giúp'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: request.status == 'Pending'
                    ? Colors.grey
                    : request.status == 'Accepted'
                        ? Colors.green
                        : Colors.red,
                borderRadius: BorderRadius.circular(3),
              ),
              padding: EdgeInsets.only(right: 8, left: 8, top: 3, bottom: 3),
              child: Text(
                request.status,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
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
                      Text(request.email ,
                          style: TextStyle(fontSize: 18)),
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
