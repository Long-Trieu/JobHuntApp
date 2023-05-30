import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/can_profile.dart';
import 'package:job_app_v3/login/login_page.dart';

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
                  FlatButton(
                    child: Text("Hủy", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.grey,
                  ),
                  FlatButton(
                    child: Text("Đăng xuất", style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      // Đăng xuất khỏi ứng dụng

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginPage.routeName,
                            (_) => false,
                      );
                    },
                    color: Colors.redAccent,
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
      appBar: AppBar(
        title: Text("Tùy chọn"),
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              SizedBox(height: 50),
              _SingleSection(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(avatar ?? ''),
                      radius: 20,
                    ),
                    title: Text(fullname ?? ''),
                    subtitle: Text(email ?? ''),
                    tileColor: Colors.white,
                    onTap: () {
                      Navigator.pushNamed(context, ProfilePage.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text('Đổi mật khẩu'),
                    leading: const Icon(Icons.vpn_key),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, LoginPage.routeName, (_) => false);
                    },
                  ),
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
                  SizedBox(height: 10),
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
                    onTap: ()  {
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
