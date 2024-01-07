import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/group.controller.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/screens/Group/group.member-list.dart';
import 'package:multiplatform_app/screens/add_event/add_event.index.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({super.key, required this.groupId});
  final String groupId;
  @override
  State<StatefulWidget> createState() => _GroupDetail();
}

class _GroupDetail extends State<GroupDetail> {
  bool isLoading = false;
  final groupController = Get.put(GroupController());
  Widget contentRequestButton = Text("Tham gia nhóm");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: groupController.fetchGroupByIdAPI(widget.groupId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Group group = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              actions: group.membership.status == 'Accepted'
                  ? [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEvent()));
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
            body: Column(
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
                      if (group.membership.status == 'Rejected' ||
                          group.membership.status == 'None')
                        FilledButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                              contentRequestButton =
                                  CircularProgressIndicator();
                            });

                            bool isRequested = await groupController
                                .fetchJoinGroupAPI(widget.groupId);
                            setState(() {
                              isLoading = false;
                              contentRequestButton = Text("Hủy yêu cầu");
                            });
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(child: contentRequestButton),
                          ),
                        ),
                      if (group.membership.status == 'Pending')
                        FilledButton(
                          onPressed: () {},
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text('Hủy yêu cầu'),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
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
