import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/contants/app_color.dart';
import 'package:multiplatform_app/general/contants/app_text_style.dart';

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
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(color: AppColor.greySoft),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: filterEdittingController,
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
          const SizedBox(height: 10)
        ]),
      ),
    );
  }
}
