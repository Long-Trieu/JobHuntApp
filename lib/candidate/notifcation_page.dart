import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_app_v3/models/api.dart';
import 'package:job_app_v3/models/notifications.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({Key key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
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
        centerTitle: true,
        title: Text(
          "Thông báo",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      right: 32, left: 32, top: 10, bottom: 20),
                  child: NotificationCard(notification: notification),
                );
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

  const NotificationCard({Key key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: notification.title != null
            ? ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(notification.avatar ?? ''),
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
                    Text(notification.dayOfCreated ?? '',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              )
            : Center(child: Text('Chưa có thông báo!')),
      ),
    );
  }
}
