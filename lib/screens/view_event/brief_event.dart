import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_icon.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/general/routes/routes.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class BriefEvent extends StatelessWidget {
  const BriefEvent(
      {super.key,
      required this.hrefs,
      required this.name,
      required this.desc,
      required this.startTime,
      required this.endTime,
      required this.address,
      required this.content});

  final List<String> hrefs;
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
          "hrefs": hrefs,
          "name": name,
          "desc": desc,
          "startTime": startTime,
          "endTime": endTime,
          "address": address,
          "content": content
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          height: MediaQuery.sizeOf(context).height / 6,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.greySoft, borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Image.network(
                      "${ApiEndPoints.baseURL}/file/${hrefs[0]}",
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
                        Text(
                          name,
                          style: AppTextStyle.textStyle_18_700_28,
                        ),
                        Text(
                          desc,
                          style: AppTextStyle.textStyle_12_400_18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "From : ${DateFormat.Hms('vi').format(DateTime.parse(startTime))}-${DateFormat.yMd('vi').format(DateTime.parse(startTime))}",
                          style: AppTextStyle.textStyle_12_600_18,
                        ),
                        Text(
                          "To : ${DateFormat.Hms('vi').format(DateTime.parse(endTime))}-${DateFormat.yMd('vi').format(DateTime.parse(endTime))}",
                          style: AppTextStyle.textStyle_12_600_18,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AppIcon.address),
                            Text(
                              address,
                              style: AppTextStyle.textStyle_12_400_18,
                              overflow: TextOverflow.visible,
                              maxLines: 1,
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
