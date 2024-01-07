import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_icon.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/screens/Admin/event_tab/event_tab.controller.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class EventDetail extends StatelessWidget {
  final eventTabController = Get.put(EventTabController());
  final List<String> hrefs;
  final String id;
  final String name;
  final String desc;
  final String startTime;
  final String endTime;
  final String address;
  final String content;

  EventDetail(
      {super.key,
        required this.hrefs,
        required this.id,
        required this.name,
        required this.desc,
        required this.startTime,
        required this.endTime,
        required this.address,
        required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sự kiện'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                await eventTabController.fetchAcceptEventAPI(id);
              },
              child: Text('Chấp nhận', style: TextStyle(color: Colors.green))),
          TextButton(
              onPressed: () async {
                await eventTabController.fetchRejectEventAPI(id);
              },
              child: Text('Từ chối', style: TextStyle(color: Colors.red)))
        ],
      ),
      body: Container(
        constraints:
        BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hrefs.length > 1
                  ? GridView(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 10),
                shrinkWrap: true,
                children: [
                  ...hrefs.map((href) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        "${ApiEndPoints.baseURL}/file/$href"),
                  ))
                ],
              )
                  : ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  "${ApiEndPoints.baseURL}/file/${hrefs[0]}",
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
                        "From : ${DateFormat.Hms('vi').format(DateTime.parse(startTime))}-${DateFormat.yMd('vi').format(DateTime.parse(startTime))}",
                        style: AppTextStyle.textStyle_14_700_20
                            .merge(const TextStyle(color: AppColor.dark)),
                      ),
                      Text(
                          "To : ${DateFormat.Hms('vi').format(DateTime.parse(endTime))}-${DateFormat.yMd('vi').format(DateTime.parse(endTime))}",
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
                  Text(
                    address,
                    style: AppTextStyle.textStyle_14_700_20
                        .merge(const TextStyle(color: AppColor.dark)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 6, left: 8),
                child: Column(
                  children: [
                    Text("About Event",
                        style: AppTextStyle.textStyle_18_700_28),
                    Text(
                      content,
                      style: AppTextStyle.textStyle_14_400_20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
