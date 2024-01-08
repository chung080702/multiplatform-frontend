import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/RequestDetail/request_detail.index.dart';
import '../models/request.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:get/get.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  final bool isOfUser;

  const RequestCard({super.key, required this.request, required this.isOfUser});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(RequestDetail(
          request: request,
          isOfUser: isOfUser,
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            request.image != ''
                ? Image.network(
                    ApiEndPoints.baseURL +
                        ApiEndPoints.fileEndPoints.getFile +
                        request.image,
                    height: 140,
                    width: 240,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 140,
                    width: 240,
                    child: Center(
                      child: Text('Yêu cầu trợ giúp'),
                    ),
                  ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${request.title}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
