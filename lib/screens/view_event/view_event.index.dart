import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/contants/app_color.dart';

class ViewEvent extends StatefulWidget {
  const ViewEvent({super.key});
  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  late TextEditingController filterEdittingController;
  @override
  void initState() {
    filterEdittingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(color: AppColor.lightWhite),
        child: Column(children: [
          TextFormField(
            controller: filterEdittingController,
            style: const TextStyle(color: AppColor.white),
          ),
          const SizedBox(height: 10)
        ]),
      ),
    );
  }
}
