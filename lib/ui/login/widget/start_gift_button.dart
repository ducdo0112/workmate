import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/widget/custom_button.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartGiftButton extends StatelessWidget {
  const StartGiftButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: S.current.register,
      buttonClick: () {
        Navigator.of(context).pushNamed(RouteDefine.register.name);
      },
      fontSize: 16.sp,
      borderSizeWidth: 3.w,
      backgroundColorEnable: AppColor.yellowOrange,
      borderSizeColor: AppColor.yellowOrange,
      isEnable: true,
    );
  }
}
