import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback buttonClick;
  final bool isEnable;
  final Color backgroundColorEnable;
  final Color backgroundColorDisable;
  final Color textColorEnable;
  final Color textColorDisable;
  final double fontSize;
  final FontWeight fontWeight;
  final double? borderRadius;
  final double? heightButton;
  final double? widthButton;
  final double? borderSizeWidth;
  final Color? borderSizeColor;
  final Color? circularProgressColor;
  final Widget? icon;
  final BlocStatus? buttonStatus;

  const CustomButton({
    Key? key,
    required this.title,
    required this.buttonClick,
    this.isEnable = false,
    this.backgroundColorEnable = AppColor.orangePeel,
    this.backgroundColorDisable = AppColor.gainsBoro,
    this.textColorEnable = AppColor.white,
    this.textColorDisable = AppColor.white,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w600,
    this.borderRadius,
    this.heightButton,
    this.widthButton,
    this.borderSizeWidth,
    this.borderSizeColor,
    this.icon,
    this.buttonStatus,
    this.circularProgressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnable
          ? () {
              buttonClick.call();
            }
          : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: borderSizeWidth != null
              ? BorderSide(
                  width: borderSizeWidth ?? 3.w,
                  color: borderSizeColor ?? Colors.white,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius ?? 6.w),
        ),
        disabledBackgroundColor: backgroundColorDisable,
        backgroundColor:
            isEnable ? backgroundColorEnable : backgroundColorDisable,
        fixedSize: Size(widthButton ?? double.infinity, heightButton ?? 44.w),
      ),
      child: Center(
        child: buttonStatus == BlocStatus.loading
            ? CircularProgressIndicator(
                color: circularProgressColor ?? AppColor.white)
            : Text(title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: isEnable ? textColorEnable : textColorDisable,
                )),
      ),
    );
  }
}
