import 'package:flutter/material.dart';
// void main() => runApp(MaterialApp(home:ApplyButtonPage()));
class ApplyButtonPage extends StatefulWidget {
  @override
  _ApplyButtonPageState createState() => _ApplyButtonPageState();
}

class _ApplyButtonPageState extends State<ApplyButtonPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _introduction;
  String _filePath;

  Widget _buildIntroductionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Introduction',
        border: OutlineInputBorder(),
      ),
      maxLines: 5,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please introduce yourself';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _introduction = value;
        });
      },
    );
  }

  Widget _buildUploadButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Open file picker
      },
      icon: Icon(Icons.upload_file),
      label: Text('Upload File'),
      style: ElevatedButton.styleFrom(primary: Colors.grey),
    );
  }

  Widget _buildApplyButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          // Handle application here
        }
      },
      child: Text('Apply'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        minimumSize: Size(double.infinity, 50),
        textStyle: TextStyle(fontSize: 20),
      ),
    );
  }



  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Apply for a job'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIntroductionField(),
              SizedBox(height: 16),
              _buildUploadButton(),
            ],
          ),
        ),
      ),
      actions: [
        _buildCancelButton(),
        SizedBox(width: 16),
        _buildApplyButton(),
      ],
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Cancel'),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        minimumSize: Size(double.infinity, 50),
        textStyle: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildDialog(context),
            );
          },
          child: Text('Apply'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            minimumSize: Size(150, 50),
            textStyle: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
