import 'package:flutter/material.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/screens/Admin/request_tab/request_card.index.dart';
import 'package:multiplatform_app/screens/Admin/request_tab/request_tab.controller.dart';
import 'package:multiplatform_app/screens/RequestView/request_brief.index.dart';

class RequestTab extends StatefulWidget {

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  late Future<List<Request>> futureRequestPendingList;
  List<Request> requestPendingList = [];
  final requestTabController = Get.put(RequestTabController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureRequestPendingList = requestTabController.fetchGetAllRequestPendingApi(1);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureRequestPendingList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildEventTabUI(snapshot.data as List<Request>);
          }
        });
  }

  Widget buildEventTabUI(List<Request> requestList) {
    return SingleChildScrollView(
      child: Column(
        children: requestList.map((request) => RequestCard(request: request)).toList(),
      ),
    );
  }


}
