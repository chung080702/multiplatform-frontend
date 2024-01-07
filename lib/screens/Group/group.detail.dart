import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/screens/Group/group.member-list.dart';
import 'package:multiplatform_app/screens/add_event/add_event.index.dart';
import 'package:multiplatform_app/screens/view_event/brief_event.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({super.key, required this.group, this.haveJoined = false});

  final Group group;
  final bool haveJoined;

  @override
  Widget build(BuildContext context) {
    if (haveJoined) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEvent()));
              },
              icon: Icon(Icons.add_rounded),
              tooltip: "Thêm sự kiện",
            ),
            MenuAnchor(
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
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
                                  )));
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
                                  )));
                    },
                  ),
                  MenuItemButton(
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
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
                ])
          ],
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
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text("${group.memberNumber} thành viên"),
                    Container(height: 8),
                    Text(group.description),
                  ],
                ),
              ),
              Column(
                children: group.events.map((event) => BriefEvent(
                    hrefs: event.imageIds,
                    name: event.name,
                    desc: event.description,
                    startTime: event.start,
                    endTime: event.end,
                    address: event.address,
                    content: event.content)).toList(),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
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
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text("${group.memberNumber} thành viên"),
                Container(height: 8),
                Text(group.description),
                Container(height: 8),
                FilledButton(
                  onPressed: () {},
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('Tham gia nhóm'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
