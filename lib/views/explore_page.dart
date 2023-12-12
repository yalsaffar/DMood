import 'package:dmood/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:dmood/widgets/post_widget.dart';
import 'package:dmood/app.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:dmood/views/mood_tracker_screen.dart';

// ignore: must_be_immutable
class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: ListView(
        children: [
          PostWidget(
              username: 'Daniel_Craig',
              userImageAsset: 'assets/images/img_avatar.png',
              postImageAsset: 'assets/images/london.jpg',
              description: 'Last day in London :( '),
          PostWidget(
            username: 'Chuck.Bartowski',
            userImageAsset: 'assets/images/img_avatar.png',
            postImageAsset: 'assets/images/bodrum.jpg',
            description: 'View of the day <3 ',
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
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
      final GlobalKey<NavigatorState> navigatorKey =
          GlobalKey<NavigatorState>();
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }
}
