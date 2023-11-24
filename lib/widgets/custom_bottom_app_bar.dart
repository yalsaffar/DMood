import 'package:flutter/material.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:dmood/pages/user_profile_screen.dart';

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomAppBarState createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
        icon: Icons.home,
        activeIcon: Icons.home,
        type: BottomBarEnum.Home,
        isSelected: true),
    BottomMenuModel(
      icon: Icons.settings,
      activeIcon: Icons.settings,
      type: BottomBarEnum.Settings,
    ),
    BottomMenuModel(
      icon: Icons.add,
      activeIcon: Icons.add,
      type: BottomBarEnum.Add,
    ),
    BottomMenuModel(
      icon: Icons.notifications,
      activeIcon: Icons.notifications,
      type: BottomBarEnum.Notification,
    ),
    BottomMenuModel(
      icon: Icons.person,
      activeIcon: Icons.person,
      type: BottomBarEnum.User,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: SizedBox(
        height: 105,
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
                  } else {
                    // Trigger onChanged for other icons
                    widget.onChanged?.call(bottomMenuList[index].type);
                  }
                },
                child: Icon(
                  bottomMenuList[index].isSelected
                      ? bottomMenuList[index].activeIcon
                      : bottomMenuList[index].icon,
                  size: 24,
                  color: bottomMenuList[index].isSelected ? Colors.blue : Colors.grey,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Settings,
  Add,
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

  IconData icon;

  IconData activeIcon;

  BottomBarEnum type;

  bool isSelected;
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







