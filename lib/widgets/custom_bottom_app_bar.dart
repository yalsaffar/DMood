import 'package:dmood/app.dart';
import 'package:flutter/material.dart';
import 'package:dmood/utils/image_constant_utils.dart';
import 'package:dmood/utils/size_utils.dart';
import 'package:dmood/views/user_profile_screen.dart';
import 'package:dmood/views/notifications_screen.dart';

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
        activeIcon: ImageConstant.imgIconlyLightHome,
        type: BottomBarEnum.Iconlylighthome,
        isSelected: true),
    BottomMenuModel(
      icon: ImageConstant.imgSettings,
      activeIcon: ImageConstant.imgSettings,
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
                onTap: () {
                  for (var element in bottomMenuList) {
                    element.isSelected = false;
                  }
                  bottomMenuList[index].isSelected = true;
                  setState(() {});

                  if (bottomMenuList[index].type == BottomBarEnum.User) {
                    // Navigate to UserProfileScreen when the User icon is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfileScreen()),
                    );
                  }  else if(bottomMenuList[index].type == BottomBarEnum.Explore) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExplorePage()),
                    );
                  }
                  else if (bottomMenuList[index].type == BottomBarEnum.Notification){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationsScreen()),
                    );
                  }
                  
                  
                  else  {
                    // Trigger onChanged for other icons
                    widget.onChanged?.call(bottomMenuList[index].type);
                  }
                },
                child: bottomMenuList[index].isSelected
                    ? CustomImageView(
                        imagePath: bottomMenuList[index].activeIcon,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      )
                    : CustomImageView(
                        imagePath: bottomMenuList[index].icon,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        color: appTheme.gray400,
                      ),
              );
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
      child: Center(
        
      ),
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







