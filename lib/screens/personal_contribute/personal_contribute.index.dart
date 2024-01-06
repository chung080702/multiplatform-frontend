import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/models/user.model.dart';
import 'package:multiplatform_app/screens/personal_contribute/personal_contribute.controller.dart';

class PersonalContribute extends StatefulWidget {
  const PersonalContribute({super.key, required this.request});

  final Request request;

  @override
  State<PersonalContribute> createState() => _PersonalContributeState();
}

class _PersonalContributeState extends State<PersonalContribute> {
  int page = 1;
  bool isLoading = false;
  List<User> users = [];
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

  @override
  void initState() {
    super.initState();
    startLoading();
    contributeController
        .getUsersBySupportRequest(widget.request.id, page)
        .then((value) {
      users = value;
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
    );
  }
}
