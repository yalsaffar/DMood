import 'package:dmood/app.dart';
import 'package:dmood/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:dmood/utils/image_constant_utils.dart';
import 'package:dmood/utils/size_utils.dart';

// ignore: must_be_immutable
class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 36.adaptSize,
          width: 36.adaptSize,
          child: CustomImageView(
            imagePath: ImageConstant.imgSend,
          ),
        ),
      ),
    );
  }
}
