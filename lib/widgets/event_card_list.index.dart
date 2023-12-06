import 'package:flutter/material.dart';
import 'package:multiplatform_app/widgets/event_card.index.dart';

class EventCardList extends StatelessWidget {
  var events = [
    EventCard(),
    EventCard(),
    EventCard(),
    EventCard(),
    EventCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              events[index],
              SizedBox(width: 5,),
            ],
          );
        },
      ),
    );
  }
}
