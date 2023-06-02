import 'package:flutter/material.dart';
import 'package:job_app_v3/models/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  static String routeName = "/changePass";

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _confirmPasswordController;
  String password;
  String id;
  APIs _apis;

  @override
  void initState() {
    super.initState();
    _getUserData();
     _apis = APIs();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      password = prefs.getString('password') ?? '';
    });
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      try {
        await _apis.changePass(
            _oldPasswordController.text, _confirmPasswordController.text);
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đổi mật khẩu thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        // Chuyển đến trang đăng nhập
        Navigator.pop(context);
      } catch (e) {
        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đổi mật khẩu thất bại!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Đổi mật khẩu',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                obscureText: true,
                controller: _oldPasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mật khẩu cũ",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.lock_outline)),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Vui lòng nhâp mật khẩu cũ!";
                  }
                  if (_oldPasswordController.text != password) {
                    return 'Sai mật khẩu cũ!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _newPasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mật khẩu mới",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.lock_outline)),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Vui lòng nhâp mật khẩu mới!";
                  }
                  if (value.length < 8) {
                    return 'Mạt khẩu mới nên có từ 8 ký tự trở lên!';
                  }
                  if (_oldPasswordController.text == value) {
                    return "Mật khẩu mới không được trùng với mật khẩu cũ!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Xác nhận mật khẩu",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.lock_outline)),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Mật khẩu không trùng khớp!";
                  }
                  if (_newPasswordController.text != value) {
                    return "Mật khẩu không trùng khớp!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: _submitForm,
                child: Text('Xác nhận'),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
