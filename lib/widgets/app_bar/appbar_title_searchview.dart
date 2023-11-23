import 'package:dmood/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:dmood/utils/size_utils.dart';
import 'package:dmood/localization/app_localization.dart';


// ignore: must_be_immutable
class AppbarTitleSearchview extends StatelessWidget {
  AppbarTitleSearchview({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomSearchView(
        width: 283.h,
        controller: controller,
        hintText: "lbl_search".tr,
      ),
    );
  }
}
