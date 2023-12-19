import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/widgets/event_card.index.dart';
import 'package:multiplatform_app/widgets/event_card_list/event_card_list.index.dart';
import 'package:multiplatform_app/widgets/event_card_list/event_list.controller.dart';

class EventCardList extends StatefulWidget {
  final Map<String, dynamic> info;

  EventCardList({required this.info});

  @override
  State<EventCardList> createState() => _EventCardListState();
}

class _EventCardListState extends State<EventCardList> {
  late Future<List<Event>> eventList;
  final eventListController = Get.put(EventListController());

  @override
  void initState() {
    super.initState();
    eventList = fetchEventList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: eventList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildGroupCardListUI(snapshot.data as List<Event>);
          }
        });
  }

  Widget buildGroupCardListUI(List<Event> eventList) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              EventCard(event: eventList[index]),
              SizedBox(width: 5,),
            ],
          );
        },
      ),
    );
  }

  Future<List<Event>> fetchEventList() async {
    if (widget.info['type'] == 'all') {
      try {
        var tmpEventList =
        await eventListController.fetchGetAllEventApi();
        return tmpEventList;
      } catch (e) {
        return [];
      }
    } else {
      return [];
    }
  }
}
