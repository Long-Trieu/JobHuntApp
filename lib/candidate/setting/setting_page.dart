import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_app_v3/candidate/jobs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/can_profile.dart';
import 'package:job_app_v3/login/login_page.dart';
import 'package:job_app_v3/candidate/setting/component/change_password_page.dart';
import 'component/applications.dart';

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
            title: Text(
              "Thông báo",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("Bạn muốn thoát khỏi ứng dụng ?"),
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
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Thoát",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      // Đăng xuất khỏi ứng dụng

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginPage.routeName,
                        (_) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),SizedBox(height: 10,)
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tùy chọn",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                height: 130,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(avatar ?? ''),
                          radius: 50,
                        ),
                        SizedBox(width: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fullname ?? '',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  )),
                              SizedBox(height: 10),
                              Text(email ?? '',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              _SingleSection(
                children: [
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
                    title: const Text('Công việc yêu thích'),
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
                    title: const Text('Công việc đã ứng tuyển'),
                    leading: const Icon(Icons.history),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pushNamed(context, Applications.routeName);
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text(
                      'Đăng xuất',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      fixedSize: const Size(150, 45),
                      textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
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
