import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_app_v3/models/api.dart';
import 'package:job_app_v3/login/login_page.dart';
import 'package:job_app_v3/models/users.dart';

class CandidateForm extends StatefulWidget {
  @override
  _CandidateFormState createState() => _CandidateFormState();
}

class _CandidateFormState extends State<CandidateForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool isMale = true;
  APIs _apis;

  @override
  void initState() {
    super.initState();
    _apis = APIs();
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      try {
        await _apis.postUser(
          _emailController.text,
          _passwordController.text,
          _fullNameController.text,
          _dobController.text,
          _phoneController.text,
          _addressController.text,
          'Candidate',
        );
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng ký thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        // Chuyển đến trang đăng nhập
        Navigator.pop(context,  User(email: _emailController.text, password: _passwordController.text));
      } catch (e) {
        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng ký thất bại!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                labelText: "Họ và tên",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.account_circle_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return "Vui lòng nhập họ tên của bạn!";
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                labelText: "Email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.email_outlined)),
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
            onSaved: (value) {
              setState(() {
                _emailController.text = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                labelText: "Mật khẩu",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.lock_outline)),
            validator: (value) {
              if (value.isEmpty) {
                return "Vui lòng nhâp mật khẩu!";
              }
              if (value.length < 8) {
                return 'Mật khẩu nên có từ 8 ký tự trở lên!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            controller: _confirmPasswordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                labelText: "Xác nhận mật khẩu",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.lock_outline)),
            validator: (value) {
              if (value.isEmpty) {
                return "Mật khẩu không trùng khớp!";
              }
              if (_passwordController.text != value) {
                return "Mật khẩu không trùng khớp!";
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              // chỉ cho phép nhập ký tự là số
              WhitelistingTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
              labelText: "Số điện thoại",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.phone_android_outlined),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Vui lòng nhập số điện thoại!";
              }
              if (value.length != 10) {
                return 'Số điện thoại phải có 10 số!';
              }
              // add your own password validation logic here
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                labelText: "Địa chỉ",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.location_on_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return "Vui lòng nhập địa chỉ!";
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                _passwordController.text = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                labelText: 'Ngày sinh',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.calendar_today_outlined)),
            controller: _dobController,
            readOnly: true,
            validator: (value) {
              if (value.isEmpty) {
                return "Vui lòng chọn ngày sinh!";
              }
              // add your own date validation logic here
              return null;
            },
            onTap: () async {
              DateTime selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());
              if (selectedDate != null) {
                setState(() {
                  _dobController.text =
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                });
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text(
                'Đăng ký',
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
        ],
      ),
    );
  }
}
