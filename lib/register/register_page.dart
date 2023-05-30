import 'package:flutter/material.dart';
import 'component/candidate_form.dart';
import 'component/employer_form.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static String routeName = "/register";

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
          "Đăng ký",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => SelectedForm(),
        child: Consumer<SelectedForm>(
          builder: (context, selectedForm, child) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: "Candidate",
                      groupValue: selectedForm.value,
                      onChanged: (value) {
                        selectedForm.value = value;
                      },
                    ),
                    Text("Ứng viên"),
                    SizedBox(width: 20),
                    Radio(
                      value: "Employer",
                      groupValue: selectedForm.value,
                      onChanged: (value) {
                        selectedForm.value = value;
                      },
                    ),
                    Text("Nhà tuyển dụng"),
                  ],
                ),
                selectedForm.value == "Candidate"
                    ? CandidateForm()
                    : EmployerForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedForm with ChangeNotifier {
  String _value = "Candidate";

  String get value => _value;

  set value(String newValue) {
    _value = newValue;
    notifyListeners();
  }
}
