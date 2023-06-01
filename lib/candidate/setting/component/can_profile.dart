import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app_v3/login/login_page.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profileCan";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isMale = true;
  String _phoneNumber = '';
  String _bio = '';
  String _address = '';
  final TextEditingController _dobController = TextEditingController();
  String _imagePath = '';
  String _pdfPath = '';
  String _gender = '';

  final genderController = TextEditingController();
  @override
  void initState() {
    super.initState();
    genderController.text = _gender;
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
      }
    });
  }

  Future<void> _getPdf() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _pdfPath = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Thông tin của bạn',
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                    leading: new Icon(Icons.photo_library),
                                    title: new Text('Photo Library'),
                                    onTap: () {
                                      _getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  new ListTile(
                                    leading: new Icon(Icons.photo_camera),
                                    title: new Text('Camera'),
                                    onTap: () {
                                      _getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(75),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _imagePath.isNotEmpty
                              ? FileImage(
                            File(_imagePath),
                          )
                              : AssetImage(
                            'images/default_avatar.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nhập họ và tên',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.account_circle_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Họ tên không được để trống!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nhập email',
                      suffixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email không được để trống!';
                    } else if (!value.contains('@')) {
                      return 'Sai định dạng email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nhập số điện thoại',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone_android_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    // chỉ cho phép nhập ký tự là số
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Số điện thoại không được bỏ trống!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Chọn giới tính',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _gender == 'male',
                            onChanged: (value) {
                              setState(() {
                                _gender = 'male';
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          Text('Male'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _gender == 'female',
                            onChanged: (value) {
                              setState(() {
                                _gender = 'female';
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          Text('Female'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Chọn ngày sinh',
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
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nhập địa chỉ',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.location_on_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Địa chỉ không được bỏ trống';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Giới thiệu bản thân',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 50,
                  maxLines: 3,
                  validator: (value) {
                    if (value != null && value.length > 300) {
                      return 'Không được nhập quá 300 ký tự!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _bio = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // Update user profile here
                        }
                      },
                      child: Text('Cập nhật'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        minimumSize: Size(double.infinity, 50),
                        textStyle: TextStyle(fontSize: 20),
                    ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
