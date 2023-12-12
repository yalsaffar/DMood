import 'package:dmood/views/mood_tracker_screen.dart';
import 'package:flutter/material.dart';
import 'package:dmood/app.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';
import 'package:dmood/routes/app_routes.dart';



// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key})
      : super(

          key: key,
        );

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Profile'),
    ),
      body: SingleChildScrollView(
      child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/img_avatar.png'),
          ),
          SizedBox(height: 20),
          Text(
            'Phil Dunphy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Madrid, Spain',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFollowersFollowing('220 '),
              _buildFollowersFollowing('150 '),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildClickableIcon(Icons.camera_alt, () {
                // Handle Instagram icon click
              }),
              _buildClickableIcon(Icons.facebook, () {
                // Handle Facebook icon click
              }),
            ],
          ),
          SizedBox(height: 16), 
          Text(
            'Shots',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, 
            ),
          ),
          SizedBox(height: 8),
          _buildShotsRow(),
          SizedBox(height: 8),
          _buildShotsRow(),
          SizedBox(height: 8),
          _buildShotsRow(),
        ],
      ),
    ),
  ),
      bottomNavigationBar: _buildBottomAppBar(context),
  );
}


  Widget _buildFollowersFollowing(String text) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Followers',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildClickableIcon(IconData icon, Function() onPressed) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: Colors.blue, // Change color as needed
      iconSize: 40,
    );
  }
   
  Widget _buildShotsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShotImage('assets/images/shot1.jpeg'), 
        _buildShotImage('assets/images/shot2.jpeg'), 
        _buildShotImage('assets/images/shot3.jpeg'), 
      ],
    );
  }

  Widget _buildShotImage(String imagePath) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Image.asset(
          imagePath,
          height: 100,
          width:100,
          fit: BoxFit.cover,
        ),
      ),
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