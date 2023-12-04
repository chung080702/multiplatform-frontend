import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:multiplatform_app/screens/Group/group.detail.dart';
import 'package:multiplatform_app/screens/Group/group.member-list.dart';
class Groups extends StatelessWidget {
  const Groups({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Groups'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded),
              tooltip: 'Search Group',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded),
              tooltip: 'Create new group',
            )
          ],
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisExtent: 288
          ),
          itemCount: 8,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GroupCard(
              title: "Hội những người có trái tim nhân ái" + '\n',
            );
          },
        )
    );
  }
}

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4/3,
            child: Image.network(
              'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg',
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
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                Text(
                  "35 thành viên",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GroupDetail())
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      side: BorderSide(style: BorderStyle.none)
                  ),
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("Tham gia"),
                      )
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