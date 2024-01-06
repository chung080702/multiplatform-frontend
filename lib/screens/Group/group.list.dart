import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/screens/Group/group.controller.dart';
import 'package:multiplatform_app/screens/Group/group.create.dart';
import 'package:multiplatform_app/screens/Group/group.detail.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/utils/color.dart';
import 'package:multiplatform_app/widgets/group_card_list/group_list.controller.dart';

class Groups extends StatelessWidget {
  Groups({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Groups'),
          bottom: TabBar(tabs: [
            Tab(
              text: "Nhóm của bạn",
            ),
            Tab(
              text: "Khám phá",
            )
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
            GroupList(info: {'type': 'ofUser'}),
            GroupList(info: {'type': 'all'}),
          ],
        ),
      ),
    );
  }
}

class GroupList extends StatefulWidget {
  final Map<String, dynamic> info;

  GroupList({required this.info});

  @override
  State<StatefulWidget> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  late Future<List<Group>> futureGroups;
  final groupListController = Get.find<GroupListController>();

  @override
  void initState() {
    super.initState();
    futureGroups = fetchGroupList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder<List<Group>>(
        future: futureGroups,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisExtent: 288),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GroupCard(
                  groupId: snapshot.data![index].id,
                  groupName: snapshot.data![index].name + '\n',
                  imageId: snapshot.data![index].imageId,
                  numberMembers: snapshot.data![index].memberNumber,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List<Group>> fetchGroupList() async {
    if (widget.info['type'] == 'all') {
      try {
        var tmpGroupList = await groupListController.fetchGetAllGroupApi();
        return tmpGroupList;
      } catch (e) {
        return [];
      }
    } else if (widget.info['type'] == 'ofUser') {
      try {
        print("user");
        var tmpGroupList = await groupListController.fetchGetAllOfUserApi();
        return tmpGroupList;
      } catch (e) {
        print(e);
        return [];
      }
    } else {
      return [];
    }
  }
}

class GroupCard extends StatelessWidget {
  const GroupCard(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.imageId,
      required this.numberMembers});

  final String groupId;
  final String groupName;
  final String imageId;
  final int numberMembers;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.network(
              'https://multiplatform-backend.vercel.app/file/$imageId',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "$numberMembers thành viên",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupDetail(
                          groupId: this.groupId,
                          groupName: this.groupName,
                          imageId: this.imageId,
                          numberMembers: this.numberMembers,
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      side: BorderSide(style: BorderStyle.none)),
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("Tham gia"),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
