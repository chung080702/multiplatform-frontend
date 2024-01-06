import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/general/widgets/alert_dialog.dart';
import 'package:multiplatform_app/models/personal_contribute.model.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/models/user.model.dart';
import 'package:multiplatform_app/screens/personal_contribute/personal_contribute.controller.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';

class PersonalContribute extends StatefulWidget {
  const PersonalContribute({super.key, required this.request});

  final Request request;

  @override
  State<PersonalContribute> createState() => _PersonalContributeState();
}

class _PersonalContributeState extends State<PersonalContribute> {
  int page = 1;
  bool isLoading = false;
  List<PersonalContributeModel> personalContributeModels = [];
  ScrollController scrollController = ScrollController();
  final PersonalContributeController contributeController =
      PersonalContributeController();

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
    page--;
  }

  Future<void> accept(String personalContributeId) async {
    startLoading();
    contributeController
        .acceptPersonalContribute(personalContributeId)
        .then((value) {
      if (value) {
        int index = personalContributeModels
            .indexWhere((element) => element.id == personalContributeId);
        setState(() {
          personalContributeModels[index].status = "Accepted";
        });
      }
      endLoading();
    });
  }

  Future<void> reject(String personalContributeId) async {
    startLoading();
    contributeController
        .rejectPersonalContribute(personalContributeId)
        .then((value) {
      if (value) {
        setState(() {
          personalContributeModels
              .removeWhere((element) => element.id == personalContributeId);
        });
      }
      endLoading();
    });
  }

  @override
  void initState() {
    super.initState();
    startLoading();
    contributeController
        .getUsersBySupportRequest(widget.request.id, page)
        .then((value) {
      personalContributeModels = value;
      endLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách người trợ giúp",
            style: AppTextStyle.textStyle_16_600_24
                .merge(const TextStyle(color: AppColor.dark))),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(controller: scrollController, children: [
                  ...personalContributeModels.map((personalContribute) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.greySoft,
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  child: Image.network(
                                    "${ApiEndPoints.baseURL}/file/${personalContribute.user.imageId}",
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        personalContribute.user.email,
                                        style: AppTextStyle.textStyle_12_400_18,
                                      ),
                                      Text(
                                        personalContribute.user.telephone,
                                        style: AppTextStyle.textStyle_12_400_18,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            personalContribute.status == "Pending"
                                ? Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showCustomAlertDialog(
                                                context: context,
                                                title:
                                                    "Bạn muốn chấp nhận sự trợ giúp từ ${personalContribute.user.id}",
                                                textContent:
                                                    'Bạn nhấn "Ok" để nhận sự giúp đỡ của ${personalContribute.user.id} sau đó hệ thống sẽ thông báo cho ${personalContribute.user.id} về điều này',
                                                textFirstButton: "Hủy",
                                                textSecondButton: "Ok",
                                                firstOnTap: () {},
                                                secondOnTap: () {
                                                  accept(personalContribute.id);
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.check,
                                            color: AppColor.textGreen,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showCustomAlertDialog(
                                                context: context,
                                                title:
                                                    "Bạn muốn từ chối sự trợ giúp từ ${personalContribute.user.id}",
                                                textContent:
                                                    'Bạn nhấn "Ok" để từ chối sự giúp đỡ của ${personalContribute.user.id} sau đó hệ thống sẽ thông báo cho ${personalContribute.user.id} về điều này',
                                                textFirstButton: "Hủy",
                                                textSecondButton: "Ok",
                                                firstOnTap: () {},
                                                secondOnTap: () {
                                                  reject(personalContribute.id);
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.cancel_outlined,
                                            color: AppColor.red,
                                          ))
                                    ],
                                  )
                                : Text(
                                    "Đã chấp nhận",
                                    style: AppTextStyle.textStyle_14_400_20
                                        .merge(const TextStyle(
                                            color: AppColor.textGreen)),
                                  )
                          ],
                        ),
                      ),
                    );
                  }),
                ]),
              ),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
