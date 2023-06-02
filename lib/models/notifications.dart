import 'package:flutter/cupertino.dart';

class NotificationModel {
  final String id;
  final String idUser;
  final String fullname;
  final String avatar;
  final String title;
  final String dayOfCreated;

  NotificationModel({
    this.id,
    this.idUser,
    this.fullname,
    this.avatar,
    this.title,
    this.dayOfCreated,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] as String,
      idUser: json['idUser'] as String,
      fullname: json['fullname'] as String,
      avatar: json['avatar'] as String,
      title: json['title'] as String,
      dayOfCreated: json['dayOfCreated'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'idUser': idUser,
        'fullname': fullname,
        'avatar': avatar,
        'title': title,
        'dayOfCreated': dayOfCreated,
      };
}
