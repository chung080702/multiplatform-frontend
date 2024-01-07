import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/group.controller.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/screens/Group/group.detail.dart';

class GroupCardJoined extends StatelessWidget {
  const GroupCardJoined({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDetailJoined(
              type: "joined",
              group: group,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                'https://multiplatform-backend.vercel.app/file/${group.imageId}',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${group.memberNumber} thành viên",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
              child: Text(
                group.description,
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupCardNotJoined extends StatefulWidget {
  GroupCardNotJoined({super.key, required this.group, required this.type});
  final String type; // "notJoined" || "pending"
  final Group group;
  @override
  State<StatefulWidget> createState() => _GroupCard();
}

class _GroupCard extends State<GroupCardNotJoined> {
  bool isLoading = false;
  final groupController = Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDetailJoined(
              type: widget.type,
              group: widget.group,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                'https://multiplatform-backend.vercel.app/file/${widget.group.imageId}',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.group.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${widget.group.memberNumber} thành viên",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            if (widget.type == "notJoined")
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: OutlinedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await groupController.fetchJoinGroupAPI(widget.group.id);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      side: BorderSide(style: BorderStyle.none)),
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("Tham gia"),
                      )),
                ),
              ),
            if (widget.type == "pending")
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      side: BorderSide(style: BorderStyle.none)),
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("Đã yêu cầu"),
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
