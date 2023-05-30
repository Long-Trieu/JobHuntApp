import 'package:flutter/material.dart';
import 'jobs.dart';
import 'applications.dart';
import 'can_notification_fragment.dart';
import 'can_profile_fragment.dart';

class CanNavigator extends StatefulWidget {
  static String routeName = "/navCan";
  @override
  _CanNavigatorState createState() => _CanNavigatorState();
}

class _CanNavigatorState extends State<CanNavigator> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Jobs(),
    Applications(),
    CanNotificationFragment(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
          color: _selectedIndex == 0 ? Colors.black : Colors.white,
              onPressed: () {
                _onTabSelected(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.list),
              color: _selectedIndex == 1 ? Colors.black : Colors.white,
              onPressed: () {
                _onTabSelected(1);
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              color: _selectedIndex == 2 ? Colors.black : Colors.white,
              onPressed: () {
                _onTabSelected(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: _selectedIndex == 3 ? Colors.black : Colors.white,
              onPressed: () {
                _onTabSelected(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


