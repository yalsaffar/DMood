import 'package:flutter/material.dart';
import 'package:dmood/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:dmood/widgets/post_widget.dart';
import 'package:dmood/app.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:dmood/views/mood_tracker_screen.dart';

// ignore: must_be_immutable
class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

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
      bottomNavigationBar: _buildBottomAppBar(context),
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

  // Reusing _buildBottomAppBar from home_container_screen.dart
}

String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
    case BottomBarEnum.Iconlylighthome:
      return AppRoutes.homeContainerScreen;
    case BottomBarEnum.Explore:
      return AppRoutes.explorePage;
    case BottomBarEnum.Iconlylightplus:
      return AppRoutes.moodTrackerScreen;
    case BottomBarEnum.Notification:
      return AppRoutes.notificationsScreen;
    case BottomBarEnum.User:
      return AppRoutes.userProfileScreen;
    default:
      return AppRoutes.homePage;
  }
}

Widget _buildBottomAppBar(BuildContext context) {
  return CustomBottomAppBar(onChanged: (BottomBarEnum type) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
  });
}
