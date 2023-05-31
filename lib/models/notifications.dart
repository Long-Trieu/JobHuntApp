class NotificationModel {
  final String id;
  final String idUser;
  final String notificationImage;
  final String title;
  final DateTime dayOfCreated;

  NotificationModel({
    this.id,
    this.idUser,
    this.notificationImage,
    this.title,
    this.dayOfCreated,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] as String,
      idUser: json['idUser'] as String,
      notificationImage: json['notificationImage'] as String,
      title: json['title'] as String,
      dayOfCreated: DateTime.parse(json['dayOfCreated'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'idUser': idUser,
        'notificationImage': notificationImage,
        'title': title,
        'dayOfCreated': dayOfCreated.toIso8601String(),
      };
}
