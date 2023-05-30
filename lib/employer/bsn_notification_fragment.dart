import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationFragment extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      avatarUrl: 'https://picsum.photos/id/237/200/300',
      title: 'User 1 đã ứng tuyển vào vị trí thực tập IT',
      time: DateTime.now(),
    ),
    NotificationItem(
      avatarUrl: 'https://picsum.photos/id/238/200/300',
      title: 'User 2 đã ứng tuyển vào vị trí phát triển phần mềm',
      time: DateTime.now().subtract(Duration(minutes: 10)),
    ),
    NotificationItem(
      avatarUrl: 'https://picsum.photos/id/239/200/300',
      title: 'User 3 đã đăng ký khóa học lập trình',
      time: DateTime.now().subtract(Duration(hours: 2)),
    ),
    NotificationItem(
      avatarUrl: 'https://picsum.photos/id/240/200/300',
      title: 'User 4 đã yêu cầu hỗ trợ kỹ thuật',
      time: DateTime.now().subtract(Duration(days: 1)),
    ),
    NotificationItem(
      avatarUrl: 'https://picsum.photos/id/241/200/300',
      title: 'User 5 đã đặt hàng sản phẩm mới',
      time: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(notification.avatarUrl),
            ),
            title: Text(notification.title),
            subtitle: Text(_formatTime(notification.time)),
            onTap: () {
              // Xử lý sự kiện khi người dùng chọn một thông báo
            },
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(time);
  }
}

class NotificationItem {
  final String avatarUrl;
  final String title;
  final DateTime time;

  NotificationItem({
     this.avatarUrl,
     this.title,
     this.time,
  });
}
