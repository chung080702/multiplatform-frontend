import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Group/group.member-list.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          MenuAnchor(
            builder: (BuildContext context, MenuController controller, Widget? child){
              return IconButton(
                onPressed: () {
                  if(controller.isOpen){
                    controller.close();
                  }else{
                    controller.open();
                  }
                },
                icon: Icon(Icons.more_vert_rounded)
              );
            },
            menuChildren: <Widget>[
              MenuItemButton(
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.group_rounded),
                    Container(width: 4,),
                    Text("Thành viên")
                  ],
                ),
                onPressed: () {},
              ),
              MenuItemButton(
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.how_to_reg_rounded),
                    Container(width: 4,),
                    Text("Yêu cầu tham gia")
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MemberList())
                  );
                },
              ),
              MenuItemButton(
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.exit_to_app_rounded),
                    Container(width: 4,),
                    Text("Rời khỏi nhóm")
                  ],
                ),
                onPressed: () {},
              ),
            ]
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.network(
              'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg',
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
                  "Group 1",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "35 thành viên"
                ),
                Container(height: 8),
                FilledButton(
                    onPressed: () {},
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('Tham gia nhóm')
                    )
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}