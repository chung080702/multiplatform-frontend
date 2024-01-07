import 'package:flutter/material.dart';
import 'package:multiplatform_app/screens/Admin/event_tab/event_tab.index.dart';
import 'package:multiplatform_app/screens/Admin/request_tab/request_tab.index.dart';

class AdminPage extends StatefulWidget {
  int index;

  AdminPage({required this.index});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

List<Widget> tabs = [
  EventTab(),
  RequestTab(),
];

class _AdminPageState extends State<AdminPage> {
  int _currentIndex = 0;

  void setIndex() {
    _currentIndex = widget.index;
  }

  @override
  void initState() {
    // TODO: implement initState
    setIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Page',
          style: TextStyle(color: Colors.blueAccent),
        ),
        centerTitle: true,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Text(
                'Sự kiện',
                style: TextStyle(
                    color:
                        _currentIndex == 0 ? Colors.blueAccent : Colors.grey),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Text('Yêu cầu',
                  style: TextStyle(
                      color: _currentIndex == 1
                          ? Colors.blueAccent
                          : Colors.grey)),
              label: ''),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
