import 'package:flutter/material.dart';
import 'reset_pass_page.dart';
class ForgotPasswordPage extends StatefulWidget {
  static String routeName = "/forgotPass";
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
          "Xác nhận email",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Nhập email bạn đã đăng ký',
                  border: OutlineInputBorder(),
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
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // Gửi mã xác nhận cho email hoặc số điện thoại đã nhập
                    // Chuyển sang trang nhập mã xác nhận và mật khẩu mới
                  }
                },
                child: Text('Gửi mã'),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Nhập mã',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                },
                child: Text('Xác nhận'),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
