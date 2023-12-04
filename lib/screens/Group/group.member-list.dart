import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Group/group.list.dart';

class MemberList extends StatelessWidget {
  const MemberList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
      ),
      body: ListView(
        children: <Widget>[
          MemberTile(),
          MemberTile(),
          MemberTile(),
          MemberTile(),
          MemberTile(),
          MemberTile(),
          MemberTile(),
        ],
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  const MemberTile({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(

        leading: CircleAvatar(
          backgroundImage: NetworkImage("https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg"),
        ),
        title: Text("Nguyễn Văn A"),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.done_rounded)
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.cancel_rounded)
            ),
          ],
        ),
      ),
    );

  }
}
