import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/widgets/group_card.index.dart';
import 'package:multiplatform_app/widgets/group_card_list/group_list.controller.dart';

class GroupCardList extends StatefulWidget {
  final Map<String, dynamic> info;

  GroupCardList({required this.info});

  @override
  State<GroupCardList> createState() => _GroupCardListState();
}

class _GroupCardListState extends State<GroupCardList> {
  late Future<List<Group>> groupList;
  final groupListController = Get.put(GroupListController());

  @override
  void initState() {
    super.initState();
    groupList = fetchGroupList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: groupList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildGroupCardListUI(snapshot.data as List<Group>);
          }
        });
  }

  Widget buildGroupCardListUI(List<Group> groupList) {
    return groupList.length > 0 ? Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: groupList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              GroupCard(group: groupList[index]),
              SizedBox(width: 5,),
            ],
          );
        },
      ),
    ) : SizedBox(height: 10,);
  }

  Future<List<Group>> fetchGroupList() async {
    if (widget.info['type'] == 'all') {
      try {
        var tmpGroupList =
        await groupListController.fetchGetAllGroupApi();
        return tmpGroupList;
      } catch (e) {
        return [];
      }
    } else if (widget.info['type'] == 'ofUser') {
      try {
        var tmpGroupList =
        await groupListController.fetchGetAllOfUserApi();
        return tmpGroupList;
      } catch (e) {
        return [];
      }
    } else {
      return [];
    }
  }
}
