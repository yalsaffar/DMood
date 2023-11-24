import 'package:flutter/material.dart';
import 'package:dmood/views/home_container_screen.dart';
import 'package:dmood/views/app_navigation_screen.dart';
import 'package:dmood/pages/user_profile_screen.dart';


class AppRoutes {
  static const String homePage = '/home_page';

  static const String homeTabContainerPage = '/home_tab_container_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String userProfileScreen = '/user_profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    homeContainerScreen: (context) => HomeContainerScreen(),
    userProfileScreen: (context) => UserProfileScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
