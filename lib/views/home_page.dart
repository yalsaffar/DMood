import 'package:flutter/material.dart';
import 'package:dmood/widgets/post_widget.dart';
import 'package:dmood/app.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          PostWidget(
            username: 'LukeDunphy',
            userImageAsset: 'assets/images/img_avatar.png',
            postImageAsset: 'assets/images/madrid.jpg',
            description: 'Beautiful day in Madrid!',
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }
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
