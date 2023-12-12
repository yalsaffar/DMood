import 'package:dmood/app.dart';
import 'package:dmood/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dmood/utils/image_constant_utils.dart';
import 'package:dmood/utils/size_utils.dart';
import 'package:dmood/views/user_profile_screen.dart';
import 'package:dmood/views/notifications_screen.dart';
import 'package:dmood/views/mood_tracker_screen.dart';

// ignore: must_be_immutable
class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomAppBarState createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgIconlyLightHome,
      activeIcon: ImageConstant.imgIconlyLightHome2,
      type: BottomBarEnum.Iconlylighthome,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSettings,
      activeIcon: ImageConstant.explore,
      type: BottomBarEnum.Explore,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconlyLightPlus,
      activeIcon: ImageConstant.imgIconlyLightPlus,
      type: BottomBarEnum.Iconlylightplus,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNotification,
      activeIcon: ImageConstant.imgNotification,
      type: BottomBarEnum.Notification,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUser,
      activeIcon: ImageConstant.imgUser,
      type: BottomBarEnum.User,
    )
  ];
  void _onItemTapped(int index) {
    // Update the isSelected property for all menu items
    for (int i = 0; i < bottomMenuList.length; i++) {
      bottomMenuList[i].isSelected = i == index;
    }

    // Set state to update the UI
    setState(() {});
    if (bottomMenuList[index].type == BottomBarEnum.User) {
      // Navigate to UserProfileScreen when the User icon is clicked
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserProfileScreen()),
      );
    } else if (bottomMenuList[index].type == BottomBarEnum.Explore) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExplorePage()),
      );
    } else if (bottomMenuList[index].type == BottomBarEnum.Notification) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotificationsScreen()),
      );
    } else if (bottomMenuList[index].type == BottomBarEnum.Iconlylighthome) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (bottomMenuList[index].type == BottomBarEnum.Iconlylightplus) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MoodTrackerPage()),
      );
    } else {
      // Trigger onChanged for other icons
      widget.onChanged?.call(bottomMenuList[index].type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: SizedBox(
        height: 105.v,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            bottomMenuList.length,
            (index) {
              return InkWell(
                  onTap: () => _onItemTapped(index),
                  child: CustomImageView(
                    imagePath: bottomMenuList[index].isSelected
                        ? bottomMenuList[index].activeIcon
                        : bottomMenuList[index].icon,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    color: bottomMenuList[index].isSelected
                        ? Colors.blue
                        : appTheme.gray400, // Change color based on selection
                  ));
            },
          ),
        ),
      ),
    );
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(),
    );
  }
}

enum BottomBarEnum {
  Iconlylighthome,
  Explore,
  Iconlylightplus,
  Notification,
  User,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
    this.isSelected = false,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;

  bool isSelected;
}
