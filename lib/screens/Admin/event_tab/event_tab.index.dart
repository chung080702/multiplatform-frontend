import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/screens/Admin/event_tab/event_card.index.dart';
import 'package:multiplatform_app/screens/Admin/event_tab/event_tab.controller.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/screens/view_event/brief_event.dart';

class EventTab extends StatefulWidget {

  @override
  State<EventTab> createState() => _EventTabState();
}

class _EventTabState extends State<EventTab> {
  late Future<List<Event>> futureEventPendingList;
  List<Event> eventPendingList = [];
  final eventTabController = Get.put(EventTabController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureEventPendingList = eventTabController.fetchGetAllEventPendingApi();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureEventPendingList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildEventTabUI(snapshot.data as List<Event>);
          }
        });
  }

  Widget buildEventTabUI(List<Event> eventList) {
    return SingleChildScrollView(
      child: Column(
        children: eventList.map((event) => EventCard(
            id: event.id,
            hrefs: event.imageIds,
            name: event.name,
            desc: event.description,
            startTime: event.start,
            endTime: event.end,
            address: event.address,
            content: event.content)).toList(),
      ),
    );
  }


}
