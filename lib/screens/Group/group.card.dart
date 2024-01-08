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
            builder: (context) => GroupDetail(
              groupId: group.id,
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

class GroupCard2 extends StatefulWidget {
  GroupCard2({super.key, required this.groupId});
  final String groupId;
  @override
  State<StatefulWidget> createState() => _GroupCard2();
}

class _GroupCard2 extends State<GroupCard2> {
  String type = 'joined';
  bool isLoading = false;
  final groupController = Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: groupController.fetchGroupByIdAPI(widget.groupId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Group group = snapshot.data!;
            if (group.membership.status == 'Accepted') {
              type = 'joined';
            } else if (group.membership.status == 'None' ||
                group.membership.status == 'Rejected') {
              type = 'notJoined';
            } else if (group.membership.status == 'Pending') {
              type = 'pending';
            }
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupDetail(
                      groupId: widget.groupId,
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
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
                        fit: BoxFit.contain,
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
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    if (type == "joined")
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                        child: Text(
                          group.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (type != "joined")
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                        child: OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (type == 'notJoined') {
                                    await groupController
                                        .fetchJoinGroupAPI(widget.groupId);
                                  } else if (type == 'pending') {
                                    await groupController.fetchDeleteMember(
                                        group.id, group.membership.accountId);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.green[100],
                              side: BorderSide(style: BorderStyle.none)),
                          child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : type == 'notJoined'
                                          ? Text("Tham gia nhóm")
                                          : Text("Hủy yêu cầu"))),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center();
        });
  }
}

class GroupCard extends StatefulWidget {
  GroupCard({super.key, required this.group, required this.type});
  final String type; // "notJoined" || "pending"
  final Group group;
  @override
  State<StatefulWidget> createState() => _GroupCard();
}

class _GroupCard extends State<GroupCard> {
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
            builder: (context) => GroupDetail(
              groupId: widget.group.id,
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
            if (widget.type == "joined")
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: Text(widget.group.description),
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
