import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/RequestView/request_brief.index.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:multiplatform_app/widgets/request_card_list/request_list.controller.dart';

class RequestView extends StatefulWidget {
  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  final requestListController = Get.find<RequestListController>();
  late Future<List<Request>> requestList;

  @override
  void initState() {
    super.initState();
    requestList = fetchRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: requestList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildRequestViewUI(snapshot.data as List<Request>);
          }
        });
  }

  Widget buildRequestViewUI(List<Request> requestList) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yêu cầu trợ giúp'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: requestList
                .map((request) => RequestBrief(request: request))
                .toList(),
          ),
        ),
      ),
    );
  }

  Future<List<Request>> fetchRequestList() async {
    try {
      var tmpRequestList = await requestListController.fetchGetAllRequestApi();
      return tmpRequestList;
    } catch (e) {
      return [];
    }
  }
}
