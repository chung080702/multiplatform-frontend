import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/group.controller.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/screens/Group/group.member-list.dart';
import 'package:multiplatform_app/screens/add_event/add_event.index.dart';
import 'package:multiplatform_app/screens/view_event/brief_event.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({super.key, required this.groupId});
  final String groupId;
  @override
  State<StatefulWidget> createState() => _GroupDetail();
}

class _GroupDetail extends State<GroupDetail> {
  String type = "joined"; // joined || notJoined || pending
  bool isLoading = false;
  final groupController = Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
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
          print(type);
          return Scaffold(
              appBar: AppBar(
                actions: group.membership.status == 'Accepted'
                    ? [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEvent(
                                          groupId: group.id,
                                        )));
                          },
                          icon: Icon(Icons.add_rounded),
                          tooltip: "Thêm sự kiện",
                        ),
                        MenuAnchor(
                          builder: (BuildContext context,
                              MenuController controller, Widget? child) {
                            return IconButton(
                                onPressed: () {
                                  if (controller.isOpen) {
                                    controller.close();
                                  } else {
                                    controller.open();
                                  }
                                },
                                icon: Icon(Icons.more_vert_rounded));
                          },
                          menuChildren: <Widget>[
                            MenuItemButton(
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.group_rounded),
                                  Container(
                                    width: 4,
                                  ),
                                  Text("Thành viên")
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MemberList(
                                      groupId: group.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                            // if (group.membership.role == 'Admin')
                            //   MenuItemButton(
                            //     child: Row(
                            //       // mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         Icon(Icons.how_to_reg_rounded),
                            //         Container(
                            //           width: 4,
                            //         ),
                            //         Text("Sự kiện đang chờ")
                            //       ],
                            //     ),
                            //     onPressed: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => MemberList(
                            //             groupId: group.id,
                            //             type: "joinRequests",
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            if (group.membership.role == 'Admin')
                              MenuItemButton(
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.how_to_reg_rounded),
                                    Container(
                                      width: 4,
                                    ),
                                    Text("Yêu cầu tham gia")
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MemberList(
                                        groupId: group.id,
                                        type: "joinRequests",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            MenuItemButton(
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app_rounded),
                                  Container(
                                    width: 4,
                                  ),
                                  Text("Rời khỏi nhóm")
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ]
                    : [],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        'https://multiplatform-backend.vercel.app/file/${group.imageId}',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            group.name,
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Text("${group.memberNumber} thành viên"),
                          Container(height: 8),
                          Text(group.description),
                          Container(height: 8),
                          if (type != 'joined')
                            FilledButton(
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (type == 'notJoined') {
                                        bool isRequested = await groupController
                                            .fetchJoinGroupAPI(widget.groupId);
                                      } else if (type == 'pending') {
                                        await groupController.fetchDeleteMember(
                                            group.id,
                                            group.membership.accountId);
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                              child: SizedBox(
                                width: double.infinity,
                                child: Center(
                                    child: isLoading
                                        ? CircularProgressIndicator()
                                        : type == 'notJoined'
                                            ? Text("Tham gia nhóm")
                                            : Text("Hủy yêu cầu")),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: group.events
                            .map((event) => BriefEvent(
                                  event: event,
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}
