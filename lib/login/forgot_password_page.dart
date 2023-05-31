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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quên mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nhập email hoặc số điện thoại của bạn',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email hoặc số điện thoại',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email hoặc số điện thoại';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                },
                child: Text('Xác nhận'),
              ),

              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // Gửi mã xác nhận cho email hoặc số điện thoại đã nhập
                    // Chuyển sang trang nhập mã xác nhận và mật khẩu mới
                  }
                },
                child: Text('Gửi mã xác nhận'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
