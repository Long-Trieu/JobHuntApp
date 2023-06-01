import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

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


  List<NotificationModel> notifications = [];


  Future<List<NotificationModel>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getString('_id');
    var res =  await http.get(Uri.parse('${url}notifications/$idUser/listNotifications'), headers: {
      'Cache-Control': 'no-cache',
    'Pragma': 'no-cache',
  });
    if (res.statusCode == 200) {
      var content = res.body;
      var arr = json.decode(content)['notification'];
      if (arr != null) {
        return (arr as List).map((e) => NotificationModel.fromJson(e)).toList();
      }
    }
    return <NotificationModel>[];
  }

}
