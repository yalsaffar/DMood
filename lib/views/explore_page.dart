import 'package:dmood/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:dmood/widgets/post_widget.dart'; 
import 'package:dmood/app.dart';
import 'package:dmood/views/home_tab_container_page.dart';
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
            description: 'Last day in London :( '
            
          ),
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

   /// Section Widget
  Widget _buildBottomAppBar(BuildContext context) {
    return CustomBottomAppBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Iconlylighthome:
        return "/";
      case BottomBarEnum.Explore:
        return "/";
      case BottomBarEnum.Iconlylightplus:
        return AppRoutes.moodTrackerScreen;
      case BottomBarEnum.Notification:
        return "/";
      case BottomBarEnum.User:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeContainerScreen:
        return HomeContainerScreen();
      case AppRoutes.moodTrackerScreen:
        return MoodTrackerPage();
      default:
        return DefaultWidget();
    }
  }
}
