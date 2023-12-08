import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiplatform_app/general/contants/app_color.dart';
import 'package:multiplatform_app/general/contants/app_icon.dart';

class BriefEvent extends StatelessWidget {
  const BriefEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.shade60Yellow,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH__I8kgPXeY9QKSEmFZJUYw4S3ftX0DTx_ZDBVuqYmBFfe89_wbp4pljDQAmZb-VhVUs&usqp=CAU",
            width: 40,
            fit: BoxFit.fitWidth,
          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name"),
              Text("description"),
              Text("Time"),
              Row(children:[
                SvgPicture.asset(AppIcon.address),
                Text("Address"),
              ],)
            ],
          ))
        ],
      ),
    );
  }
}
