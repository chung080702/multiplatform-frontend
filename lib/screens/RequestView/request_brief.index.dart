import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/RequestDetail/request_detail.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class RequestBrief extends StatelessWidget {
  Request request;

  RequestBrief({required this.request});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(245, 245, 245, 1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            request.image != ''
                ? Image.network(
              ApiEndPoints.baseURL +
                  ApiEndPoints.fileEndPoints.getFile +
                  request.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
                : Container(
              height: 150,
              width: 100,
              child: Center(
                child: Text('Yêu cầu trợ giúp'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      request.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: request.status == 'Pending'
                            ? Colors.grey
                            : request.status == 'Accepted'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding:
                      EdgeInsets.only(right: 8, left: 8, top: 3, bottom: 3),
                      child: Text(
                        request.status,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  'Phone: ${request.phone}',
                ),
                Text('Email: ${request.email}')
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Get.to(RequestDetail(request: request));
      },
    );
  }
}
