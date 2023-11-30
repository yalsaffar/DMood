import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'like',
      'username': 'sarah.walker',
      'message': 'liked your photo.',
      'profileImage': 'assets/images/img_avatar.png',
    },
    {
      'type': 'comment',
      'username': 'john.casey',
      'message': 'commented: "Great post!"',
      'profileImage': 'assets/images/img_avatar.png',
    },
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(notification['profileImage']),
              child: Text(notification['username'][0]),
            ),
            title: Text(notification['username']),
            subtitle: Text(notification['message']),
            trailing: _buildNotificationTypeIcon(notification['type']),
            onTap: () {
              // Add functionality to handle tapping on a notification
              print('Tapped on notification at index $index');
            },
          );
        },
      ),
    );
  }

  // Helper method to display notification icons based on type
  Icon _buildNotificationTypeIcon(String type) {
    switch (type) {
      case 'like':
        return Icon(Icons.favorite, color: Colors.red);
      case 'comment':
        return Icon(Icons.comment, color: Colors.blue);
      // Add more cases for other notification types
      default:
        return Icon(Icons.notifications);
    }
  }
}