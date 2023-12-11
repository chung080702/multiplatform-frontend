import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_icon.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';

class DetailEvent extends StatelessWidget {
  const DetailEvent(
      {super.key,
      required this.href,
      required this.name,
      required this.desc,
      required this.startTime,
      required this.endTime,
      required this.address,
      required this.content});

  final String href;
  final String name;
  final String desc;
  final String startTime;
  final String endTime;
  final String address;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: AppColor.greySoft,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  href,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        name,
                        style: AppTextStyle.textStyle_24_600_36,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        desc,
                        style: AppTextStyle.textStyle_12_400_18
                            .merge(const TextStyle(color: AppColor.grey)),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.calendar_month,
                      size: 32,
                      color: AppColor.shade80Blue,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "From $startTime",
                        style: AppTextStyle.textStyle_14_700_20
                            .merge(const TextStyle(color: AppColor.dark)),
                      ),
                      Text("To $endTime",
                          style: AppTextStyle.textStyle_14_700_20
                              .merge(const TextStyle(color: AppColor.dark))),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        AppIcon.address,
                        height: 32,
                        fit: BoxFit.fitHeight,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "From $startTime",
                        style: AppTextStyle.textStyle_14_700_20
                            .merge(const TextStyle(color: AppColor.dark)),
                      ),
                      Text("To $endTime",
                          style: AppTextStyle.textStyle_14_700_20
                              .merge(const TextStyle(color: AppColor.dark))),
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text("About Event",
                    style: AppTextStyle.textStyle_18_700_28),
              ),
              Text(content, style: AppTextStyle.textStyle_14_400_20,)
            ],
          ),
        ),
      ),
    );
  }
}