import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_app_v3/models/api.dart';
import 'package:job_app_v3/models/cities.dart';
import 'package:job_app_v3/models/experiences.dart';
import 'package:job_app_v3/models/joblevels.dart';
import 'package:job_app_v3/models/jobtypes.dart';
import 'package:job_app_v3/models/majors.dart';
import 'package:job_app_v3/models/salary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  final _jobNameController = TextEditingController();
  final _numberOfCandidatesController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _candidateRequirementsController = TextEditingController();
  final _benefitsController = TextEditingController();
  final _deadlineController = TextEditingController();
  APIs _apis;
  String _gender;
  String _selectedMajor;
  String _selectedSalary;
  String _selectedJobType;
  String _selectedJobLevel;
  String _selectedExperience;
  String _selectedCity;
  String _jobName = '';
  String id;
  String avatar;
  String fullname;

  List<Major> _majorList = [];
  List<Salary> _salaryList = [];
  List<City> _cityList = [];
  List<JobType> _jobTypeList = [];
  List<JobLevel> _jobLevelList = [];
  List<Experience> _experienceList = [];

  Future<void> getMajor() async {
    APIs api = APIs();
    final data = await api.getMajorData();
    setState(() {
      _majorList = data;
    });
  }

  Future<void> getCity() async {
    APIs api = APIs();
    final data = await api.getCityData();
    setState(() {
      _cityList = data;
    });
  }

  Future<void> getSalary() async {
    APIs api = APIs();
    final data = await api.getSalaryData();
    setState(() {
      _salaryList = data;
    });
  }

  Future<void> getExperience() async {
    APIs api = APIs();
    final data = await api.getExperienceData();
    setState(() {
      _experienceList = data;
    });
  }

  Future<void> getJobLevel() async {
    APIs api = APIs();
    final data = await api.getJobLevelData();
    setState(() {
      _jobLevelList = data;
    });
  }

  Future<void> getJobType() async {
    APIs api = APIs();
    final data = await api.getJobTypeData();
    setState(() {
      _jobTypeList = data;
    });
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('_id') ?? '';
      fullname = prefs.getString('fullname') ?? '';
      avatar = prefs.getString('avatar') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _apis = APIs();
    _getUserData();
    getMajor();
    getCity();
    getExperience();
    getJobLevel();
    getSalary();
    getJobType();
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      try {
        await _apis.postJob(
          _jobNameController.text,
          avatar,
          fullname,
          _numberOfCandidatesController.text,
          _gender,
          _jobDescriptionController.text,
          _candidateRequirementsController.text,
          _benefitsController.text,
          _deadlineController.text,
          _selectedMajor,
          id,
          _selectedSalary,
          _selectedJobType,
          _selectedJobLevel,
          _selectedExperience,
          _selectedCity,
        );
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thêm tin tuyển dụng thành công!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thêm tin tuyển dụng thất bại!'),
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
          "Thêm tin tuyển việc",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 32, left: 32, top: 10, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tên công việc',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _jobNameController,
                  decoration: InputDecoration(
                    labelText: 'Nhập tên công việc',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên công việc';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Text(
                  'Thông tin chung',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mức lương",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedSalary,
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedSalary = newValue;
                              });
                            },
                            items: _salaryList.map((Salary salary) {
                              return DropdownMenuItem<String>(
                                value: salary.id,
                                child: Text(salary.rangeSalary),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Số lượng cần tuyển",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _numberOfCandidatesController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập số lượng cần tuyển';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hình thức làm việc",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedJobType,
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedJobType = newValue;
                              });
                            },
                            items: _jobTypeList.map((JobType jobType) {
                              return DropdownMenuItem<String>(
                                value: jobType.id,
                                child: Text(jobType.jobTypeName),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Địa điểm",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedCity,
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedCity = newValue;
                              });
                            },
                            items: _cityList.map((City city) {
                              return DropdownMenuItem<String>(
                                value: city.id,
                                child: Text(city.cityName),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cấp bậc công việc",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedJobLevel,
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedJobLevel = newValue;
                              });
                            },
                            items: _jobLevelList.map((JobLevel jobLevel) {
                              return DropdownMenuItem<String>(
                                value: jobLevel.id,
                                child: Text(jobLevel.level),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kinh nghiệm",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedExperience,
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedExperience = newValue;
                              });
                            },
                            items: _experienceList.map((Experience experience) {
                              return DropdownMenuItem<String>(
                                value: experience.id,
                                child: Text(experience.exp),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chuyên ngành",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedMajor,
                              onChanged: (String newValue) {
                                setState(() {
                                  _selectedMajor = newValue;
                                });
                              },
                              items: _majorList.map((Major major) {
                                return DropdownMenuItem<String>(
                                  value: major.id,
                                  child: Text(major.majorName),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Chọn giới tính ứng viên',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                    SizedBox(width: 10),
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
                    SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _gender == 'Cả 2',
                            onChanged: (value) {
                              setState(() {
                                _gender = 'Cả 2';
                              });
                            },
                          ),
                          Text('Cả 2'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      labelText: 'Hạn nộp hồ sơ',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.calendar_today_outlined)),
                  controller: _deadlineController,
                  readOnly: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Vui lòng chọn thành lập công ty!";
                    }
                    // add your own date validation logic here
                    return null;
                  },
                  onTap: () async {
                    DateTime selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2050));
                    if (selectedDate != null) {
                      setState(() {
                        _deadlineController.text =
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                      });
                    }
                  },
                ),
                SizedBox(height: 32.0),
                Text(
                  'Mô tả công việc',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _jobDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Nhập mô tả công việc',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mô tả công việc';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Text(
                  'Yêu cầu ứng viên',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _candidateRequirementsController,
                  decoration: InputDecoration(
                    labelText: 'Nhập yêu cầu ứng viên',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập yêu cầu ứng viên';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Text(
                  'Quyền lợi được hưởng',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _benefitsController,
                  decoration: InputDecoration(
                    labelText: 'Nhập quyền lợi được hưởng',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập quyền lợi được hưởng';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Đăng tin tuyển dụng',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      fixedSize: const Size(180, 45),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
