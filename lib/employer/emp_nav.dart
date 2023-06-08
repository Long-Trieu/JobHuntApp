import 'package:flutter/material.dart';
import 'package:job_app_v3/employer/emp_listjob_fragment.dart';
import 'package:job_app_v3/candidate/setting/component/can_profile.dart';

import 'package:job_app_v3/candidate/main.dart';
import 'emp_listjob_fragment.dart';
import 'emp_addjob_fragment.dart';
import 'bsn_notification_fragment.dart';
import 'package:job_app_v3/candidate/can_home_fragment.dart';
import 'package:job_app_v3/candidate/notifcation_page.dart';
import 'package:job_app_v3/candidate/setting/setting_page.dart';

// void main() => runApp(MaterialApp(home:BusinessNavigation()));

class EmpNavigation extends StatefulWidget {
  static String routeName = "/navEmp";
  @override
  _EmpNavigationState createState() => _EmpNavigationState();
}

class _EmpNavigationState extends State<EmpNavigation> {
  int _selectedIndex = 0;

  static List<Widget> _pages = [
    MyApp(),
    JobPage(),
    AddJobPage(),
    NotificationListPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => _onItemTapped(0),
              color: _selectedIndex == 0 ? Colors.black : Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () => _onItemTapped(1),
              color: _selectedIndex == 1 ? Colors.black : Colors.grey,
            ),
            SizedBox(width: 32),
            MaterialButton(
              onPressed: () => _onItemTapped(2),
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
              minWidth: 48,
              height: 48,
              shape: CircleBorder(),
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => _onItemTapped(3),
              color: _selectedIndex == 3 ? Colors.black : Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _onItemTapped(4),
              color: _selectedIndex == 4 ? Colors.black : Colors.grey,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
