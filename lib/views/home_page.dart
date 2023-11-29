import 'package:dmood/app.dart';
import 'package:flutter/material.dart';
import 'package:dmood/utils/size_utils.dart';
import 'package:dmood/utils/image_constant_utils.dart';
import 'package:dmood/localization/app_localization.dart';
import 'package:dmood/widgets/post_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PostWidget(
          username: 'LukeDunphy',
          userImageAsset:  'assets/images/img_avatar.png',
          postImageAsset: 'assets/images/madrid.jpg',
          description: 'Beautiful day in Madrid!',
          
        ),
        
      ],
    );
  }
}

