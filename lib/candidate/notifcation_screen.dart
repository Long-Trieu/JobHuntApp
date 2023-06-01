import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_app_v3/models/api.dart';
import 'package:job_app_v3/models/notifications.dart';


class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key key}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  Future<List<NotificationModel>> notificationListFuture;

  @override
  void initState() {
    super.initState();

      APIs api = APIs();
      notificationListFuture = api.getNotifications();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: notificationListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NotificationModel> notifications = snapshot.data;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                NotificationModel notification = notifications[index];
                return NotificationCard(notification: notification);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({Key key, this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: notification.notificationImage != null
          ? ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(notification.notificationImage),
          backgroundColor: Colors.white,
          radius: 20,
        ),
        contentPadding:
        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.title ?? '',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text(notification.dayOfCreated.toString() ?? '',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      )
          : Center(child: Text('Chưa có thông báo!')),
    );
  }
}
