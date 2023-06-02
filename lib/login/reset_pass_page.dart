import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  static String routeName = "/resetPass";

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _newPasswordController;
  TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Đặt lại mật khẩu",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 65, left: 20, right: 20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Nhập mật khẩu mới',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                      suffixIcon: Icon(Icons.lock_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Nhập lại mật khẩu mới',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                      suffixIcon: Icon(Icons.lock_outlined),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text(
                        'Đặt lại mật khẩu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        fixedSize: const Size(160, 45),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
