import 'package:flutter/material.dart';
import 'jobs.dart';
import 'notifcation_page.dart';
import 'search_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'setting/setting_page.dart';

class CanNavigator extends StatefulWidget {
  static String routeName = "/navCan";
  CanNavigator({Key key}) : super(key: key);
  @override
  State<CanNavigator> createState() => _CanNavigatorState();
}

class _CanNavigatorState extends State<CanNavigator> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Jobs(),
    SearchPage(),
    NotificationListPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Trang chủ"),
    selectedColor: Colors.indigo,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("Tìm kiếm"),
    selectedColor: Colors.indigo,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.notifications_none_outlined),
    title: const Text("Thông báo"),
    selectedColor: Colors.indigo,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.list),
    title: const Text("Tùy chọn"),
    selectedColor: Colors.indigo,
  ),
];


