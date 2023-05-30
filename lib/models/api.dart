import 'dart:convert';
import 'dart:io';

import 'users.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/strings.dart';

class APIs {
  String url = "http://192.168.1.2:3000/api/";

//User
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

}
