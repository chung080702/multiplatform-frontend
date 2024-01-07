import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/direct_support/direct_support.index.dart';
import 'package:multiplatform_app/screens/personal_contribute/personal_contribute.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class RequestDetail extends StatelessWidget {
  RequestDetail({super.key, required this.request, this.isOfUser});

  bool? isOfUser;
  Request request;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu cầu trợ giúp'),
        centerTitle: true,
        actions: [
          if (isOfUser != null && !isOfUser!)
            IgnorePointer(
              ignoring: request.status == 'Pending',
              child: Opacity(
                opacity: request.status == 'Pending' ? 0.2 : 1,
                child: InkWell(
                  onTap: () {
                    Get.to(DirectSupport(
                      request: request,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding: const EdgeInsets.only(
                          right: 8, left: 8, top: 3, bottom: 3),
                      child: const Text(
                        "Support",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: request.status == 'Pending'
                    ? Colors.grey
                    : request.status == 'Accepted'
                        ? Colors.green
                        : Colors.red,
                borderRadius: BorderRadius.circular(3),
              ),
              padding:
                  const EdgeInsets.only(right: 8, left: 8, top: 3, bottom: 3),
              child: Text(
                request.status,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (isOfUser != null && isOfUser!) show(context)
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

  show(BuildContext context) {
    return MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                size: 20,
              ));
        },
        menuChildren: <Widget>[
          MenuItemButton(
            child: Row(
              children: [
                const Icon(Icons.group_rounded),
                Container(
                  width: 4,
                ),
                Text(
                  "Những người trợ giúp",
                  style: AppTextStyle.textStyle_14_400_20
                      .merge(const TextStyle(color: AppColor.dark)),
                )
              ],
            ),
            onPressed: () {
              Get.to(PersonalContribute(
                request: request,
              ));
            },
          ),
        ]);
  }
}
