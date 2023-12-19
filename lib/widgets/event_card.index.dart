import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/detail_event/detail_event.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import '../models/event.model.dart';
import 'package:get/get.dart';


class EventCard extends StatelessWidget {
  Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DetailEvent(href: ApiEndPoints.baseURL + ApiEndPoints.fileEndPoints.getFile + event.imageIds[0], name: event.name, desc: event.description, startTime: event.start, endTime: event.end, address: event.address, content: event.content));
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              ApiEndPoints.baseURL + ApiEndPoints.fileEndPoints.getFile + event.imageIds[0],
              height: 140,
              width: 240,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${event.name}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}