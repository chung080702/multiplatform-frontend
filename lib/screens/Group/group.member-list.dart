import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/group.controller.dart';
import 'package:multiplatform_app/models/join_group_request.model.dart';
import 'package:multiplatform_app/models/member.model.dart';

class MemberList extends StatefulWidget {
  MemberList({super.key, required this.groupId, this.type = "members"});
  String type; // joinRequests || members
  final String groupId;
  @override
  State<StatefulWidget> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  late Future<List<JoinGroupRequest>> futureJoinGroupRequest;
  late Future<List<Member>> futureFetchAllMembers;
  final groupController = Get.put(GroupController());

  @override
  void initState() {
    super.initState();
    futureJoinGroupRequest = fetchJoinGroupRequest();
    futureFetchAllMembers = fetchAllMembersOfGroup();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == "joinRequests") {
      return Scaffold(
          appBar: AppBar(
            title: Text("Yêu cầu tham gia"),
          ),
          body: FutureBuilder<List<JoinGroupRequest>>(
            future: futureJoinGroupRequest,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return MemberJoinRequestTile(
                        joinGroupRequest: snapshot.data![index]);
                  },
                  itemCount: snapshot.data!.length,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Thành viên"),
        ),
        body: FutureBuilder<List<Member>>(
          future: futureFetchAllMembers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MemberTile(member: snapshot.data![index]);
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<List<JoinGroupRequest>> fetchJoinGroupRequest() async {
    try {
      var tmp = await groupController.fetchGetAllJoinGroupRequestAPI(
          widget.groupId, 1);
      return tmp;
    } catch (e) {
      return [];
    }
  }

  Future<List<Member>> fetchAllMembersOfGroup() async {
    try {
      var tmp =
          await groupController.fetchGetAllMemberOfGroupAPI(widget.groupId, 1);
      return tmp;
    } catch (e) {
      return [];
    }
  }
}

class MemberJoinRequestTile extends StatelessWidget {
  const MemberJoinRequestTile({super.key, required this.joinGroupRequest});
  final JoinGroupRequest joinGroupRequest;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg"),
        ),
        title: Text(this.joinGroupRequest.user.id),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.cancel_rounded)),
          ],
        ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  const MemberTile({super.key, required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg"),
        ),
        title: Text(member.user.id),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.delete_rounded)),
          ],
        ),
      ),
    );
  }
}
