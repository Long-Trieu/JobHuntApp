import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/can_profile.dart';
import 'package:job_app_v3/login/login_page.dart';
import 'package:job_app_v3/candidate/setting/component/change_password_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String email;
  String fullname;
  String avatar;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      fullname = prefs.getString('fullname') ?? '';
      avatar = prefs.getString('avatar') ?? '';
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Thông báo", textAlign: TextAlign.center,),
            content: Text("Bạn có muốn thoát khỏi ứng dụng ?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text("Hủy", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                        "Đăng xuất", style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      // Đăng xuất khỏi ứng dụng

                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      await prefs.clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginPage.routeName,
                            (_) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 48, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.align_horizontal_left, size: 28),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Tùy chọn',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.align_horizontal_right, size: 28),
                  ],
                ),
              ),
              SizedBox(height: 50),
              _SingleSection(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(avatar ?? ''),
                      radius: 30,
                    ),
                    tileColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    onTap: () {
                      Navigator.pushNamed(context, ProfilePage.routeName);
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fullname ?? '', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 5),
                        Text(email ?? '', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: const Text('Đổi mật khẩu'),
                    leading: const Icon(Icons.vpn_key),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pushNamed(
                          context, ChangePasswordPage.routeName);
                    },
                  ),
                  SizedBox(height: 3),
                  ListTile(
                    title: const Text('Danh sách công việc yêu thích'),
                    leading: const Icon(Icons.favorite_border),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, LoginPage.routeName, (_) => false);
                    },
                  ),
                  SizedBox(height: 3),
                  ListTile(
                    title: const Text('Danh sách công việc đã ứng tuyển'),
                    leading: const Icon(Icons.history),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, LoginPage.routeName, (_) => false);
                    },
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    title: const Text(
                      'Đăng xuất',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    tileColor: Colors.redAccent,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SingleSection({
    Key key,
    this.title,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
