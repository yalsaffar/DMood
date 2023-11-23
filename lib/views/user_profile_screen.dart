import 'package:flutter/material.dart';
import 'package:dmood/app.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';
import 'package:dmood/utils/image_constant_utils.dart';
import 'package:dmood/utils/size_utils.dart';
import 'package:dmood/localization/app_localization.dart';
import 'package:dmood/widgets/custom_elevated_button.dart';
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
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildHeaderStack(context),
              SizedBox(height: 15.v),
              Text(
                "lbl_bruno_pham2".tr,
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 9.v),
              Text(
                "msg_da_nang_vietnam".tr,
                style: CustomTextStyles.bodyLargeBluegray300,
              ),
              SizedBox(height: 21.v),
              _buildComponentRow(context),
              SizedBox(height: 20.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgGlobe1,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                  ),
                  Container(
                    height: 6.adaptSize,
                    width: 6.adaptSize,
                    margin: EdgeInsets.only(
                      left: 24.h,
                      top: 7.v,
                      bottom: 7.v,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3.h,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment(1, 1),
                        end: Alignment(0, 0),
                        colors: [
                          appTheme.indigoA100,
                          appTheme.indigo500,
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgUInstagram,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    margin: EdgeInsets.only(left: 24.h),
                  ),
                  Container(
                    height: 6.adaptSize,
                    width: 6.adaptSize,
                    margin: EdgeInsets.only(
                      left: 24.h,
                      top: 7.v,
                      bottom: 7.v,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3.h,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment(1, 1),
                        end: Alignment(0, 0),
                        colors: [
                          appTheme.indigoA100,
                          appTheme.indigo500,
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgFacebook,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    margin: EdgeInsets.only(left: 24.h),
                  ),
                ],
              ),
              SizedBox(height: 23.v),
              _buildTabsBarRow(context),
              SizedBox(height: 47.v),
              CustomImageView(
                imagePath: ImageConstant.imgGroup6999,
                height: 180.v,
                width: 186.h,
              ),
              SizedBox(height: 46.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildNavigationBarrBottomAppBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderStack(BuildContext context) {
    return SizedBox(
      height: 146.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 106.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgMaskGroup,
                    height: 106.v,
                    width: 375.h,
                    alignment: Alignment.center,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 16.v,
                        right: 16.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 4.v,
                              bottom: 2.v,
                            ),
                            child: Text(
                              "lbl_brunopham".tr,
                              style: CustomTextStyles.bodyMediumWhiteA700,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgSettingsWhiteA700,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                            margin: EdgeInsets.only(left: 101.h),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse194,
            height: 80.adaptSize,
            width: 80.adaptSize,
            radius: BorderRadius.circular(
              40.h,
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.h),
      padding: EdgeInsets.symmetric(vertical: 9.v),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.v),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "lbl_220".tr,
                    style: CustomTextStyles.bodyLarge_1,
                  ),
                  TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: "lbl_followers".tr,
                    style: CustomTextStyles.bodyLargeGray400,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "lbl_150".tr,
                  style: CustomTextStyles.bodyLarge_1,
                ),
                TextSpan(
                  text: " ",
                ),
                TextSpan(
                  text: "lbl_following".tr,
                  style: CustomTextStyles.bodyLargeGray400,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTabsBarRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomElevatedButton(
            width: 177.h,
            text: "lbl_0_shots".tr,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 9.v,
              right: 36.h,
              bottom: 10.v,
            ),
            child: Text(
              "lbl_10_collections".tr,
              style: CustomTextStyles.bodyLargeGray400_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNavigationBarrBottomAppBar(BuildContext context) {
    return CustomBottomAppBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Iconlylighthome:
        return AppRoutes.homeTabContainerPage;
      case BottomBarEnum.Settings:
        return "/";
      case BottomBarEnum.Iconlylightplus:
        return "/";
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
      case AppRoutes.homeTabContainerPage:
        return HomeTabContainerPage();
      default:
        return DefaultWidget();
    }
  }
}
