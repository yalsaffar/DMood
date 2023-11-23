import 'package:dmood/app.dart';
import 'package:flutter/material.dart';
import 'package:dmood/utils/size_utils.dart';
import 'package:dmood/utils/image_constant_utils.dart';
import 'package:dmood/localization/app_localization.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 19.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      _buildFrame(context),
                      SizedBox(height: 16.v),
                      _buildFrame(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildFrame(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 10.v,
            ),
            decoration: AppDecoration.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgAvatar,
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    top: 4.v,
                    bottom: 6.v,
                  ),
                  child: Text(
                    "lbl_bruno".tr,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowDown,
                  height: 16.v,
                  width: 14.h,
                  margin: EdgeInsets.only(
                    left: 6.h,
                    top: 9.v,
                    bottom: 5.v,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 7.v,
                    bottom: 5.v,
                  ),
                  child: Text(
                    "lbl_1_hour_ago".tr,
                    style: CustomTextStyles.bodyMediumGray400,
                  ),
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMsnyz9l6gs4224x335,
            height: 224.v,
            width: 335.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 12.v,
            ),
            decoration: AppDecoration.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgPlusCircle1,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.v),
                  child: Text(
                    "lbl_20".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconlyLightChat,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.only(left: 6.h),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.h,
                    bottom: 2.v,
                  ),
                  child: Text(
                    "lbl_125".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgHeart2,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.only(left: 6.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
