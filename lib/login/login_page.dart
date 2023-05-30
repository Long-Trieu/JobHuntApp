import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_app_v3/login/forgot_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../candidate/main.dart';
import '../register/register_page.dart';
import '../employer/business_nav.dart';
import '../candidate/can_nav.dart';

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
        _value = prefs.getBool('check') ?? false;
      });
    }
  }

  Widget _buildUsernameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      controller: email,
      onSaved: (_value) {
        setState(() {
          email.text = _value;
        });
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      controller: password,
      onSaved: (_value) {
        setState(() {
          password.text = _value;
        });
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, EmpNavigation.routeName);
        },
        child: Text(
          'Forgot Password ?',
          style: TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.popAndPushNamed(context, RegisterPage.routeName);
        },
        child: Text(
          'Don’t have an account? Register here',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Text(
                'Welcome ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                'to JobHunt',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 32),
              _buildUsernameField(),
              SizedBox(height: 16),
              _buildPasswordField(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 200),
                  _buildForgotPasswordButton(),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    final url = Uri.parse(
                        'http://192.168.1.25:3000/api/users/login');
                    final response = await http.post(
                      url,
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({
                        'email': email.text,
                        'password': password.text,
                      }),
                    );
                    if (response.statusCode == 200) {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      prefs.setString('email', email.text);
                      prefs.setString('password', password.text);
                      prefs.setBool('check', _value);

                      var userData = json.decode(response.body);
                      var role = userData['role'];
                      print('Check role: $role');
                      print('Check response: ${response.body}');

                      if (role == 'Candidate') {
                        Navigator.pushNamed(
                            context, CanNavigator.routeName);
                      } else {
                        Navigator.pushNamed(
                            context, EmpNavigation.routeName);
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
                        msg: 'Đã xảy ra lỗi trong quá trình đăng nhập',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  }
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 30),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
