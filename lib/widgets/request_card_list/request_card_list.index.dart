import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/widgets/request_card.index.dart';
import 'package:multiplatform_app/widgets/request_card_list/request_list.controller.dart';

class RequestCardList extends StatefulWidget {
  final Map<String, dynamic> info;

  RequestCardList({required this.info});

  @override
  State<RequestCardList> createState() => _RequestCardListState();
}

class _RequestCardListState extends State<RequestCardList> {
  late Future<List<Request>> requestList;
  List<Request> requests = [];
  bool isLoading = true;
  final requestListController = Get.put(RequestListController());

  @override
  void initState() {
    super.initState();
    requestList = fetchRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? FutureBuilder(
            future: requestList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                isLoading = false;
                requests = snapshot.data as List<Request>;
                return buildGroupCardListUI(snapshot.data as List<Request>);
              }
            })
        : buildGroupCardListUI(requests);
  }

  Widget buildGroupCardListUI(List<Request> requestList) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: requestList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              RequestCard(
                request: requestList[index],
                isOfUser: widget.info['type'] == 'all' ? false : true,
              ),
              SizedBox(
                width: 5,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<Request>> fetchRequestList() async {
    if (widget.info['type'] == 'all') {
      try {
        var tmpRequestList =
            await requestListController.fetchGetAllRequestApi(1);
        return tmpRequestList;
      } catch (e) {
        return [];
      }
    } else if (widget.info['type'] == 'ofUser') {
      try {
        var tmpRequestList =
            await requestListController.fetchGetAllRequestOfUserApi();
        return tmpRequestList;
      } catch (e) {
        return [];
      }
    } else {
      return [];
    }
  }
}
