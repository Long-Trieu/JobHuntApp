import 'package:flutter/material.dart';
import 'component/candidate_form.dart';
import 'component/employer_form.dart';


class RegisterPage extends StatefulWidget {
  static String routeName = "/register";
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _selectedForm = "Candidate";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Đăng ký"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: "Candidate",
                  groupValue: _selectedForm,
                  onChanged: (value) {
                    setState(() {
                      _selectedForm = value;
                    });
                  },
                ),
                Text("Ứng viên"),
                SizedBox(width: 20),
                Radio(
                  value: "Employer",
                  groupValue: _selectedForm,
                  onChanged: (value) {
                    setState(() {
                      _selectedForm = value;
                    });
                  },
                ),
                Text("Nhà tuyển dụng"),
              ],
            ),
            _selectedForm == "Candidate" ? CandidateForm() : EmployerForm(),
          ],
        ),
      ),
    );
  }
}
