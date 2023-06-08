import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app_v3/login/login_page.dart';
import 'package:job_app_v3/models/api.dart';
import 'package:job_app_v3/models/majors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profileCan";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String _email;
  bool _isMale = true;
  String _phoneNumber;
  String _bio;
  String _dob;
  String _address;
  String _imagePath = '';
  String _gender;
  String _idMajor;
  String _id;
  APIs _apis;
  List<Major> majorList = [];
  String selectedIdMajor = '';
  String _avatar;
  String id;
  bool _isEditable = false;
  File imageFile;
  bool showSpinner = false;

  Future<void> _uploadAvatar(String userId, File imageFile) async {
    try {
      // Tạo request
      final url =
          Uri.parse('http://192.168.1.20:3000/api/users/$userId/updateAvatar');
      var request = http.MultipartRequest('POST', url);

      // Thêm file vào request
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('avatar', stream, imageLength);
      request.files.add(multipartFile);

      // Thực hiện yêu cầu
      var response = await request.send();

      // Kiểm tra kết quả
      if (response.statusCode == 200) {
        print('Upload thành công!');
      } else {
        print('Upload thất bại! Mã lỗi: ${response.statusCode}');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print('Lỗi khi tải lên avatar: $e');
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('_id') ?? '';

      // Upload ảnh lên server
      await _uploadAvatar(userId, File(pickedFile.path));
    }
  }

  Future<void> getMajor() async {
    APIs api = APIs();
    final data = await api.getMajorData();
    setState(() {
      majorList = data;
    });
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = prefs.getString('_id') ?? '';
      fullnameController.text = prefs.getString('fullname') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      _avatar = prefs.getString('avatar') ?? '';
      dobController.text = prefs.getString('dayOfBirth') ?? '';
      addressController.text = prefs.getString('address') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      bioController.text = prefs.getString('bio') ?? '';
      _gender = prefs.getString('gender') ?? '';
      selectedIdMajor = prefs.getString('idMajor') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _apis = APIs();
    getMajor();
    _getUserData();
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      try {
        await _apis.updateUser(
            emailController.text,
            fullnameController.text,
            _gender,
            dobController.text,
            phoneController.text,
            addressController.text,
            selectedIdMajor,
            bioController.text);
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cập nhật thông tin thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        // Chuyển đến trang đăng nhập
        Navigator.pop(context);
      } catch (e) {
        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cập nhật thông tin thất bại!'),
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
        centerTitle: true,
        title: Text(
          "Thông tin của bạn",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
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
                    child: ModalProgressHUD(
                      inAsyncCall: showSpinner,
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
                                : NetworkImage(_avatar ?? ''),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: Icon(Icons.account_circle_outlined),
                  ),
                  enabled: _isEditable,
                  // initialValue: _fullname ?? '',
                  controller: fullnameController  ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Họ tên không được để trống!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      fullnameController.text = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  enabled: _isEditable,
                  // initialValue: _email ?? '',
                  controller: emailController ?? '',
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
                      emailController.text = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: Icon(Icons.phone_android_outlined),
                  ),
                  enabled: _isEditable,
                  // initialValue: _phoneNumber ?? '',
                  controller: phoneController ?? '',
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
                      phoneController.text = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        'Giới tính',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _gender == 'Nam',
                            onChanged: (value) {
                              setState(() {
                                _gender = 'Nam';
                              });
                            },
                          ),
                          Text('Nam'),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _gender == 'Nữ',
                            onChanged: (value) {
                              setState(() {
                                _gender = 'Nữ';
                              });
                            },
                          ),
                          Text('Nữ'),
                        ],
                      ),
                    ),
                    SizedBox(width: 80),
                  ],
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Chuyên ngành',
                    enabled: _isEditable,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  value: selectedIdMajor,
                  onChanged: (newValue) {
                    setState(() {
                      selectedIdMajor = newValue;
                    });
                  },
                  items: majorList.map((Major major) {
                    return DropdownMenuItem<String>(
                      value: major.id,
                      child: Text(major.majorName),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                TextFormField(
                  enabled: _isEditable,
                  // initialValue: _dob,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Ngày sinh',
                      suffixIcon: Icon(Icons.calendar_today_outlined)),
                  controller: dobController,
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
                        dobController.text =
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}' ?? '';
                      });
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  enabled: _isEditable,
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                      addressController.text = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  enabled: _isEditable,
                  // initialValue: _bio,
                  controller: bioController,
                  decoration: InputDecoration(
                    labelText: 'Giới thiệu bản thân',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  maxLength: 500,
                  maxLines: 3,
                  validator: (value) {
                    if (value != null && value.length > 500) {
                      return 'Không được nhập quá 500 ký tự!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      bioController.text = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isEditable = true;
                          });
                        },
                        icon: Icon(Icons.create_outlined),
                        tooltip: 'Chỉnh sửa',
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                          fixedSize: const Size(100, 45),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
