import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_icon.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/general/routes/routes.dart';

class BriefEvent extends StatelessWidget {
  const BriefEvent(
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
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.eventDetail, arguments: {
          "href": href,
          "name": name,
          "desc": desc,
          "startTime": startTime,
          "endTime": endTime,
          "address": address,
          "content" : content
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          height: MediaQuery.sizeOf(context).height / 6,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.greySoft,
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius:const BorderRadius.all(Radius.circular(4)),
                    child: Image.network(
                      href,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )),
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTextStyle.textStyle_18_700_28),
                        Text(
                          desc,
                          style: AppTextStyle.textStyle_12_400_18,
                        ),
                        Row(
                          children: [
                            Text(
                              startTime,
                              style: AppTextStyle.textStyle_14_600_20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              endTime,
                              style: AppTextStyle.textStyle_14_600_20,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AppIcon.address),
                            Text(
                              address,
                              style: AppTextStyle.textStyle_12_400_18,
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
