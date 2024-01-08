import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/screens/Group/group.card.dart';
import 'package:multiplatform_app/screens/Group/group.controller.dart';
import 'package:multiplatform_app/screens/Group/group.create.dart';
import 'package:multiplatform_app/screens/Group/group.detail.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/screens/Home/home.index.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/utils/color.dart';
import 'package:multiplatform_app/widgets/group_card_list/group_list.controller.dart';

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
                childAspectRatio: 0.68,
              ),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(4),
              itemBuilder: (context, index) {
                // return GroupCard(
                //   type: widget.info['type'],
                //   group: snapshot.data![index],
                // );
                return GroupCard2(groupId: snapshot.data![index].id);
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
    if (widget.info['type'] == 'notJoined') {
      try {
        var tmpGroupList = await groupListController.fetchGetAllGroupNoneApi();
        return tmpGroupList;
      } catch (e) {
        return [];
      }
    } else if (widget.info['type'] == 'joined') {
      try {
        var tmpGroupList = await groupListController.fetchGetAllOfUserApi();
        return tmpGroupList;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (widget.info['type'] == 'pending') {
      var tmpGroupList = await groupListController.fetchGetAllGroupPendingApi();
      return tmpGroupList;
    } else {
      return [];
    }
  }
}
