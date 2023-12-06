import 'package:flutter/material.dart';
import 'package:multiplatform_app/widgets/group_card.index.dart';

class GroupCardList extends StatelessWidget {
  var groups = [
    GroupCard(),
    GroupCard(),
    GroupCard(),
    GroupCard(),
    GroupCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              groups[index],
              SizedBox(width: 5,),
            ],
          );
        },
      ),
    );
  }
}
