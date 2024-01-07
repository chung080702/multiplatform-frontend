import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/screens/view_event/brief_event.dart';
import 'package:multiplatform_app/screens/view_event/view_event.controller.dart';
import 'package:multiplatform_app/models/event.model.dart';

class ViewEvent extends StatefulWidget {
  const ViewEvent({super.key});

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  late TextEditingController filterEditingController;
  ViewEventController viewEventController = ViewEventController();
  ScrollController scrollController = ScrollController();
  List<Event> events = [];
  int page = 1;
  bool isLoading = false;

  void addEvents(List<Event> addedEvents) {
    if (mounted) {
      setState(() {
        events = [...events, ...addedEvents];
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
    page--;
  }

  void init() {
    startLoading();
    viewEventController
        .getEvents(page, filterEditingController.text)
        .then((addedEvents) {
      addEvents(addedEvents);
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
        viewEventController
            .getEvents(page, filterEditingController.text)
            .then((addedEvents) {
          if (addedEvents.isEmpty) {
            backPage();
          } else {
            addEvents(addedEvents);
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
              onTap: () {
                startLoading();
                viewEventController
                    .getEvents(page, filterEditingController.text)
                    .then((newEvents) {
                  setState(() {
                    events = newEvents;
                  });
                  endLoading();
                });
              },
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
              if (events.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: events.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BriefEvent(
                        event: events[index],
                      );
                    },
                  ),
                ),
              if (isLoading) const CircularProgressIndicator(),
            ]),
      ),
    );
  }
}
