import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/group.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class GroupCard extends StatelessWidget {
  Group group;

  GroupCard({required this.group});

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
            ApiEndPoints.baseURL + ApiEndPoints.fileEndPoints.getFile + group.imageId,
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
                  group.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                Text(
                  '${group.memberNumber} thành viên',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}