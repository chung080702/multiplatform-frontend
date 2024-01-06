import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';

showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String textContent,
  required String textFirstButton,
  required String textSecondButton,
  required VoidCallback firstOnTap,
  required VoidCallback secondOnTap,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppTextStyle.textStyle_16_600_24
                .merge(const TextStyle(color: AppColor.dark)),
            textAlign: TextAlign.center,
          ),
          content: Text(
            textContent,
            style: AppTextStyle.textStyle_12_400_18
                .merge(const TextStyle(color: AppColor.dark)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                firstOnTap.call();
                Get.back();
              },
              child: Text(
                textFirstButton,
                style: AppTextStyle.textStyle_16_600_24,
              ),
            ),
            TextButton(
              onPressed: () {
                secondOnTap.call();
                Get.back();
              },
              child: Text(
                textSecondButton,
                style: AppTextStyle.textStyle_16_600_24,
              ),
            ),
          ],
        );
      });
}
