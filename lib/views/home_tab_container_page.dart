import 'package:dmood/app.dart';
import 'package:dmood/widgets/app_bar/appbar_title_searchview.dart';
import 'package:dmood/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:dmood/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dmood/utils/size_utils.dart';
import 'package:dmood/localization/app_localization.dart';
import 'package:dmood/utils/image_constant_utils.dart';

// ignore_for_file: must_be_immutable
class HomeTabContainerPage extends StatefulWidget {
  const HomeTabContainerPage({Key? key})
      : super(
          key: key,
        );

  @override
  HomeTabContainerPageState createState() => HomeTabContainerPageState();
}

class HomeTabContainerPageState extends State<HomeTabContainerPage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTabview(context),
                SizedBox(
                  height: 551.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      HomePage(),
                      HomePage(),
                      HomePage(),
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

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitleSearchview(
        margin: EdgeInsets.only(left: 20.h),
        hintText: "lbl_search".tr,
        controller: searchController,
      ),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgSend,
          margin: EdgeInsets.fromLTRB(16.h, 12.v, 20.h, 12.v),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 51.v,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.indigoA100,
        labelStyle: TextStyle(
          fontSize: 16.fSize,
          fontFamily: 'ABeeZee',
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelColor: appTheme.gray400,
        unselectedLabelStyle: TextStyle(
          fontSize: 16.fSize,
          fontFamily: 'ABeeZee',
          fontWeight: FontWeight.w400,
        ),
        indicatorPadding: EdgeInsets.all(
          6.0.h,
        ),
        indicator: BoxDecoration(
          color: appTheme.gray10002,
          borderRadius: BorderRadius.circular(
            6.h,
          ),
        ),
        tabs: [
          Tab(
            child: Text(
              "lbl_popular".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_trending".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_following".tr,
            ),
          ),
        ],
      ),
    );
  }
}
