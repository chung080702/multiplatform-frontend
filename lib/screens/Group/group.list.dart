import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/screens/Group/group.controller.dart';
import 'package:multiplatform_app/screens/Group/group.create.dart';
import 'package:multiplatform_app/screens/Group/group.detail.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<StatefulWidget> createState() => _GroupsState();

}

class _GroupsState extends State<Groups> {
  late Future<List<Group>> futureGroups;

  @override
  void initState() {
    super.initState();
    futureGroups = fetchGroup();
  }
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGroup())
                );
              },
              icon: const Icon(Icons.add_rounded),
              tooltip: 'Create new group',
            )
          ],
        ),
        body: FutureBuilder<List<Group>>(
          future: futureGroups,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisExtent: 288
                ),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GroupCard(
                    title: snapshot.data![index].name + '\n',
                    imageId: snapshot.data![index].imageId,
                    memberNumber: snapshot.data![index].memberNumber,
                  );
                },
              );
            } else if (snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.title,
    required this.imageId,
    required this.memberNumber
  });
  final String title;
  final String imageId;
  final int memberNumber;
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
                  "$memberNumber thành viên",
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