import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Group/group.index.dart';
import 'package:multiplatform_app/screens/Profile/profile.index.dart';
import 'package:multiplatform_app/screens/RequestView/request_view.index.dart';
import 'package:multiplatform_app/screens/view_event/view_event.index.dart';
import 'package:multiplatform_app/utils/color.dart';
import 'package:multiplatform_app/widgets/event_card_list/event_card_list.index.dart';
import 'package:multiplatform_app/widgets/group_card_list/group_card_list.index.dart';
import 'package:multiplatform_app/widgets/request_card_list/request_card_list.index.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    GroupPage(),
    ProfilePage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundGradientFirst,
                  backgroundGradientSecond,
                ],
              )),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [Icon(Icons.search)],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Các hội nhóm thiện nguyện",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              GroupCardList(
                info: {
                  'type': 'all',
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Các sự kiện sắp diễn ra",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ViewEvent());
                    },
                    child: Text(
                      'Xem thêm',
                      style: TextStyle(
                          color: backgroundGradientFirst,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              EventCardList(info: {
                'type': 'all',
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Các yêu cầu trợ giúp",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(RequestView());
                    },
                    child: Text(
                      'Xem thêm',
                      style: TextStyle(
                          color: backgroundGradientFirst,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              RequestCardList(info: {
                'type': 'all',
              })
            ],
          ),
        ),
      ),
    );
  }
}
