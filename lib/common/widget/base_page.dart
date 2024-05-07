import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/image/app_images.dart';
import 'package:workmate/utils/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildBasePage({
  required Widget body,
  Color backgroundColor = AppColor.white,
  PreferredSizeWidget? appBar,
  bool? extendBodyBehindAppBar,
  bool? resizeToAvoidBottomInset,
  bool showFloatingActionButton = false,
  bool showDrawer = true,
  VoidCallback? floatingButtonAction,
}) {
  return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: body,
        floatingActionButton: showFloatingActionButton
            ? buildFloatingButton(floatingButtonAction)
            : null,
      ));
}

Widget buildFloatingButton(VoidCallback? floatingButtonAction) {
  return GestureDetector(
    onTap: () {
      if (floatingButtonAction != null) {
        floatingButtonAction.call();
      }
    },
    child: Container(
      width: 67.w,
      height: 67.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SvgPicture.asset(AppImages.floatingButton),
    ),
  );
}