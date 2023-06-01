import 'dart:convert';
import 'dart:io';

import 'package:job_app_v3/models/experiences.dart';
import 'package:job_app_v3/models/joblevels.dart';
import 'package:job_app_v3/models/jobtypes.dart';
import 'package:job_app_v3/models/salary.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cities.dart';
import 'majors.dart';
import 'users.dart';
import 'notifications.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/strings.dart';

class APIs {
  String url = "http://192.168.1.10:3000/api/";

// User
  Future<User> postUser(
      String email,
      String password,
      String fullname,
      String dayOfBirth,
      String phone,
      String address,
      String role) async {
    final response = await http.post(
      Uri.parse('${url}users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'fullname': fullname,
        'dayOfBirth': dayOfBirth,
        'phone': phone,
        'address': address,
        'role': role
      }),
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Account.');
    }
  }

  Future<User> changePass(
      String oldPassword,
      String newPassword,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('_id') ?? '';

    final response = await http.put(
      Uri.parse('${url}users/$id/change-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to change Pass!');
    }
  }


  //Notification
  List<NotificationModel> notifications = [];
  Future<List<NotificationModel>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getString('_id');
    var res =  await http.get(Uri.parse('${url}notifications/$idUser/listNotifications'));
    if (res.statusCode == 200) {
      var content = res.body;
      var arr = json.decode(content)['notification'];
      if (arr != null) {
        return (arr as List).map((e) => NotificationModel.fromJson(e)).toList();
      }
    }
    return <NotificationModel>[];
  }


  //Major
  Future<List<Major>> getMajorData() async {
    final response = await http.get(Uri.parse('${url}majors'));
    final jsonData = json.decode(response.body);
    List<dynamic> jsonList = jsonData['major'];
    return jsonList.map((json) => Major.fromJson(json)).toList();
  }

  //City
  Future<List<City>> getCityData() async {
    final response = await http.get(Uri.parse('${url}cities'));
    final jsonData = json.decode(response.body);
    List<dynamic> jsonList = jsonData['city'];
    return jsonList.map((json) => City.fromJson(json)).toList();
  }

  //Experience
  Future<List<Experience>> getExperienceData() async {
    final response = await http.get(Uri.parse('${url}experiences'));
    final jsonData = json.decode(response.body);
    List<dynamic> jsonList = jsonData['experience'];
    return jsonList.map((json) => Experience.fromJson(json)).toList();
  }

  //JobLevel
  Future<List<JobLevel>> getJobLevelData() async {
    final response = await http.get(Uri.parse('${url}job_levels'));
    final jsonData = json.decode(response.body);
    List<dynamic> jsonList = jsonData['job_level'];
    return jsonList.map((json) => JobLevel.fromJson(json)).toList();
  }

  //JobType
  Future<List<JobType>> getJobTypeData() async {
    final response = await http.get(Uri.parse('${url}job_types'));
    final jsonData = json.decode(response.body);
    List<dynamic> jsonList = jsonData['job_type'];
    return jsonList.map((json) => JobType.fromJson(json)).toList();
  }

  //Salary
  Future<List<Salary>> getSalaryData() async {
    final response = await http.get(Uri.parse('${url}salaries'));
    final jsonData = json.decode(response.body);
    List<dynamic> jsonList = jsonData['salary'];
    return jsonList.map((json) => Salary.fromJson(json)).toList();
  }

}
