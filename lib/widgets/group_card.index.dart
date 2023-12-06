import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
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
            'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg',
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
                  'Nhóm 1',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                Text(
                  "35 thành viên",
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