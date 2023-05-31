import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'register/register_page.dart';
import 'login/login_page.dart';
import 'splash_page.dart';
import 'employer/business_nav.dart';
import 'candidate/can_nav.dart';
import 'login/forgot_password_page.dart';
import 'candidate/setting/component/can_profile.dart';
import 'candidate/setting/component/change_password_page.dart';
import 'login/reset_pass_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        LoginPage.routeName : (context) =>  LoginPage(),
        RegisterPage.routeName: (context) =>  RegisterPage(),
        EmpNavigation.routeName: (context) => EmpNavigation(),
        CanNavigator.routeName: (context) => CanNavigator(),
        ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
        ChangePasswordPage.routeName: (context) => ChangePasswordPage(),
      },
    );
  }
}