import 'package:dmood/app.dart';
import 'package:flutter/material.dart';
import 'package:dmood/views/home_container_screen.dart';
import 'package:dmood/views/user_profile_screen.dart';
import 'package:dmood/views/mood_tracker_screen.dart';
import 'package:dmood/views/explore_page.dart';
import 'package:dmood/views/notifications_screen.dart';

class AppRoutes {
  static const String homePage = '/home_page';

  static const String homeTabContainerPage = '/home_tab_container_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String userProfileScreen = '/user_profile_screen';

  //static const String appNavigationScreen = '/app_navigation_screen';

  static const String moodTrackerScreen = '/mood_tracker_screen';
  
  static const String explorePage = '/explore_page';
  
  static const String notificationsScreen = '/notifications_screen';

  static Map<String, WidgetBuilder> routes = {
    homeTabContainerPage: (context) => HomeTabContainerPage(),
    homeContainerScreen:(context) => HomeContainerScreen(),
    explorePage: (context) => ExplorePage(),
    moodTrackerScreen: (context) => MoodTrackerPage(),
    notificationsScreen: (context) => NotificationsScreen(),
    userProfileScreen: (context) => UserProfileScreen(),
  };
}
