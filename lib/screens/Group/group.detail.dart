import 'package:flutter/material.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

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