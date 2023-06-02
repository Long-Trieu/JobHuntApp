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
        child: Padding(
          padding: EdgeInsets.only(top: 30,bottom: 65, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Nhập email bạn đã đăng ký',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.email_outlined),
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
                    ),
                    SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: Text(
                          'Gửi mã',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // Gửi mã xác nhận cho email hoặc số điện thoại đã nhập
                            // Chuyển sang trang nhập mã xác nhận và mật khẩu mới
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                          fixedSize: const Size(85, 45),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'Nhập mã bạn đã nhận',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.message_outlined),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text(
                      'Xác nhận mã',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      // if (_formKey.currentState.validate()) {
                      //   // Gửi mã xác nhận cho email hoặc số điện thoại đã nhập
                      //   // Chuyển sang trang nhập mã xác nhận và mật khẩu mới
                      // }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      fixedSize: const Size(130, 45),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
