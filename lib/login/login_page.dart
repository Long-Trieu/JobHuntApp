import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_app_v3/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../register/register_page.dart';
import '../employer/business_nav.dart';
import '../candidate/can_nav.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _value = false;
  var prefs;
  final email = TextEditingController();
  final password = TextEditingController();
  String _fullname;
  String _avatar;
  String id;
  FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _getData();
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email')?.isNotEmpty ?? false) {
      setState(() {
        email.text = prefs.getString('email') ?? '';
        password.text = prefs.getString('password') ?? '';
        id = prefs.getString('_id') ?? '';
        _fullname = prefs.getString('fullname') ?? '';
        _avatar = prefs.getString('avatar') ?? '';
        _value = prefs.getBool('check') ?? false;
      });
    }
  }

  void handleLogin() async {
    if (_formKey.currentState.validate()) {
      final url = Uri.parse('http://192.168.1.13:3000/api/users/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email.text,
          'password': password.text,
        }),
      );
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email.text);
        prefs.setString('password', password.text);
        prefs.setBool('check', _value);

        var userData = json.decode(response.body);
        var role = userData['role'];
        var _fullname = userData['fullname'];
        var _avatar = userData['avatar'];
        var id = userData['_id'];
        prefs.setString('_id', id);
        prefs.setString('fullname', _fullname);
        prefs.setString('avatar', _avatar);
        print('Check role: $role');
        print('Check response: ${response.body}');

        if (role == 'Candidate') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Chào mừng bạn trở lại!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamed(context, CanNavigator.routeName);
        } else {
          Navigator.pushNamed(context, EmpNavigation.routeName);
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        final message = responseData['message'];

        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'data',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  Widget _buildUsernameField() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 300,
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Nhập email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Vui lòng nhâp Email!";
            }
            RegExp regex = RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
            if (!regex.hasMatch(value)) {
              return 'Email không hợp lệ!';
            }
            return null;
          },
          controller: email,
          onSaved: (_value) {
            setState(() {
              email.text = _value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 300,
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Nhập mật khẩu',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return "Vui lòng nhâp mật khẩu!";
            }
            if (value.length < 8) {
              return 'Mật khẩu ít hơn 8 ký tự!';
            }
            return null;
          },
          controller: password,
          onSaved: (_value) {
            setState(() {
              password.text = _value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: EdgeInsets.only(right: 65),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 160,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, ForgotPasswordPage.routeName);
            },
            child: Text(
              'Bạn quên mật khẩu ?',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Nếu bạn chưa có tài khoản ? ",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          TextButton(
            onPressed: () async {
              final result =
                  await Navigator.pushNamed(context, RegisterPage.routeName);
              User user = result as User;
              email.text = user.email;
              password.text = user.password;
            },
            child: Text(
              "Hãy đăng ký ngay!",
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                ),
                SizedBox(height: 32),
                _buildUsernameField(),
                SizedBox(height: 16),
                _buildPasswordField(),
                SizedBox(height: 10),
                _buildForgotPasswordButton(),
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: handleLogin,
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      fixedSize: const Size(120, 45),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
