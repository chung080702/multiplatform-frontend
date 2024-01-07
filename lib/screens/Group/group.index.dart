import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Group/group.create.dart';
import 'package:multiplatform_app/screens/Group/group.list.dart';

class GroupPage extends StatelessWidget {
  GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nhóm'),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(text: "Nhóm của bạn"),
            Tab(text: "Khám phá"),
            Tab(text: "Đang chờ")
          ]),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded),
              tooltip: 'Search Group',
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateGroup()));
              },
              icon: const Icon(Icons.add_rounded),
              tooltip: 'Create new group',
            )
          ],
        ),
        body: TabBarView(
          children: [
            GroupList(info: {'type': 'joined'}),
            GroupList(info: {'type': 'notJoined'}),
            GroupList(info: {'type': 'pending'}),
          ],
        ),
      ),
    );
  }
}
