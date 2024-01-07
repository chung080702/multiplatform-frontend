import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_icon.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/general/routes/routes.dart';
import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class BriefEvent extends StatelessWidget {
  const BriefEvent({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.eventDetail, arguments: {
          "hrefs": event.imageIds,
          "name": event.name,
          "desc": event.description,
          "startTime": event.start,
          "endTime": event.end,
          "address": event.address,
          "content": event.content
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          height: MediaQuery.sizeOf(context).height / 5 + 14,
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
                      "${ApiEndPoints.baseURL}/file/${event.imageIds[0]}",
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
                          event.name,
                          style: AppTextStyle.textStyle_18_700_28,
                        ),
                        Text(
                          event.description,
                          style: AppTextStyle.textStyle_12_400_18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "From : ${DateFormat.Hms('vi').format(DateTime.parse(event.start))}-${DateFormat.yMd('vi').format(DateTime.parse(event.start))}",
                          style: AppTextStyle.textStyle_12_600_18,
                        ),
                        Text(
                          "To : ${DateFormat.Hms('vi').format(DateTime.parse(event.end))}-${DateFormat.yMd('vi').format(DateTime.parse(event.end))}",
                          style: AppTextStyle.textStyle_12_600_18,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AppIcon.address),
                            Text(
                              event.address,
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
