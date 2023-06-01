import 'package:flutter/material.dart';
import 'package:job_app_v3/models/api.dart';
import 'package:job_app_v3/models/cities.dart';
import 'package:job_app_v3/models/experiences.dart';
import 'package:job_app_v3/models/joblevels.dart';
import 'package:job_app_v3/models/jobtypes.dart';
import 'package:job_app_v3/models/majors.dart';
import 'package:job_app_v3/models/salary.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _selectedMajor;
  String _selectedSalary;
  String _selectedJobType;
  String _selectedJobLevel;
  String _selectedExperience;
  String _selectedCity;
  String _jobName = '';

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

  @override
  void initState() {
    super.initState();
    getMajor();
    getCity();
    getExperience();
    getJobLevel();
    getSalary();
    getJobType();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nhập tên công việc',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),

              onSaved: (value) {
                setState(() {
                  _jobName = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const SizedBox(width: 16.0),
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
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const SizedBox(width: 16.0),
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
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thành phố",
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () {
// Perform search operation here
              },
              child: Text("Tìm kiếm"),
            ),
          ],
        ),
      ),
    );
  }
}
