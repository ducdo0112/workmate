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
      width: 50.w,
      height: 50.w,
      decoration: const BoxDecoration(
        color: AppColor.orangePeel,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: const Icon(Icons.add, color: AppColor.white,),
    ),
  );
}