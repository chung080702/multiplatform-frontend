// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multiplatform_app/models/request.model.dart';
// import 'package:multiplatform_app/screens/RequestView/request_brief.index.dart';
// import 'package:multiplatform_app/utils/api_endpoint.dart';
// import 'package:multiplatform_app/widgets/request_card_list/request_list.controller.dart';
//
// class RequestView extends StatefulWidget {
//   @override
//   State<RequestView> createState() => _RequestViewState();
// }
//
// class _RequestViewState extends State<RequestView> {
//   final requestListController = Get.find<RequestListController>();
//   late Future<List<Request>> requestList;
//
//   @override
//   void initState() {
//     super.initState();
//     requestList = fetchRequestList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: requestList,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return buildRequestViewUI(snapshot.data as List<Request>);
//           }
//         });
//   }
//
//   Widget buildRequestViewUI(List<Request> requestList) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Yêu cầu trợ giúp'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: requestList
//                 .map((request) => RequestBrief(request: request))
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<List<Request>> fetchRequestList() async {
//     try {
//       var tmpRequestList = await requestListController.fetchGetAllRequestApi(1);
//       return tmpRequestList;
//     } catch (e) {
//       return [];
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/RequestView/request_brief.index.dart';
import 'package:multiplatform_app/widgets/request_card_list/request_list.controller.dart';


class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  late TextEditingController filterEditingController;
  final requestController = RequestListController();
  ScrollController scrollController = ScrollController();
  List<Request> requests = [];
  int page = 1;
  bool isLoading = false;

  void addRequests(List<Request> addedRequests) {
    if (mounted) {
      setState(() {
        requests = [...requests, ...addedRequests];
      });
    }
  }

  void startLoading() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
  }

  void endLoading() {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void nextPage() {
    page++;
  }

  void backPage() {
    page++;
  }

  void init() {
    startLoading();
    requestController.fetchGetAllRequestApi(page).then((addedRequests) {
      addRequests(addedRequests);
      endLoading();
    });
  }

  @override
  void initState() {
    super.initState();
    filterEditingController = TextEditingController();
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        startLoading();
        nextPage();
        requestController.fetchGetAllRequestApi(page).then((addedRequests) {
          if (addedRequests.isEmpty) {
            backPage();
          } else {
            addRequests(addedRequests);
          }
          endLoading();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: filterEditingController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search...",
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
                style: const TextStyle(
                    color: AppColor.dark,
                    decoration: TextDecoration.none,
                    decorationThickness: 0)
                    .merge(AppTextStyle.textStyle_12_400_18),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColor.buttonGreen,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                child: const Text(
                  "Search",
                  style: AppTextStyle.textStyle_12_600_18,
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: AppColor.white),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              if (requests.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: requests.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RequestBrief(request: requests[index]);
                    },
                  ),
                ),
              if (isLoading) const CircularProgressIndicator(),
            ]),
      ),
    );
  }
}
