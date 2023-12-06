import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            'https://www.socialtables.com/wp-content/uploads/2016/10/iStock-540095978.jpg',
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
                  'Sự kiện 1',
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
    );
  }
}