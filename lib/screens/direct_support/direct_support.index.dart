import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/RequestDetail/request_detail.index.dart';
import 'package:multiplatform_app/screens/direct_support/direct_support.controller.dart';
import 'package:get/get.dart';

class DirectSupport extends StatefulWidget {
  const DirectSupport({super.key, required this.request});

  final Request request;

  @override
  State<DirectSupport> createState() => _DirectSupportState();
}

class _DirectSupportState extends State<DirectSupport> {
  final DirectSupportController directSupportController =
      DirectSupportController();
  List<File> images = [];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images = [...images, File(image.path)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Trực tiếp trợ giúp",
          style: AppTextStyle.textStyle_16_600_24
              .merge(const TextStyle(color: AppColor.dark)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ảnh minh chứng",
              style: AppTextStyle.textStyle_14_400_20
                  .merge(const TextStyle(color: AppColor.dark)),
            ),
            Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.grey300),
              ),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.grey300)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...images.map((image) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          height: double.infinity,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(image, fit: BoxFit.cover),
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: double.infinity,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: AppColor.grey300),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  print("${widget.request.id}");
                  bool isSuccess = await directSupportController
                      .createPersonalContribute(images, widget.request.id);
                  if (isSuccess) {
                    Get.to(RequestDetail(request: widget.request));
                  } else {}
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: const Text(
                    "Trợ giúp",
                    style: AppTextStyle.textStyle_14_700_20,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
