import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/widget/loading_progress.dart';
import 'package:flutter/material.dart';

class OutlinedButtonCustom extends StatelessWidget {
  final VoidCallback? action;
  final String text;
  final Color textColorEnable;
  final Color textColorDisable;
  final Color outlinedColor;
  final Color? boxShadowColor;
  final Color backgroundColorEnable;
  final Color backgroundColorDisable;
  final bool enable;
  final bool isLoading;
  final double borderRadius;
  final double heightButton;
  final double textSize;
  final double outlinedWidth;
  final Widget? icon;

  const OutlinedButtonCustom({
    Key? key,
    this.action,
    required this.text,
    this.textColorEnable = AppColor.black,
    this.textColorDisable = AppColor.quickSilver,
    this.outlinedColor = AppColor.yellowOrange,
    this.boxShadowColor,
    this.backgroundColorEnable = AppColor.white,
    this.backgroundColorDisable = AppColor.white,
    this.isLoading = false,
    this.enable = true,
    this.borderRadius = 28,
    this.heightButton = 56,
    this.textSize = 17,
    this.outlinedWidth = 1,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!enable || isLoading) return;
        action?.call();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: heightButton,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: enable ? backgroundColorEnable : backgroundColorDisable,
          border: Border.all(
            color: outlinedColor,
            width: outlinedWidth,
          ),
          boxShadow: boxShadowColor != null
              ? [
                  BoxShadow(
                    color: boxShadowColor!,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  )
                ]
              : null,
        ),
        child: Center(
          child: isLoading
              ? const LoadingProgress()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) icon!,
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: textSize,
                        color: enable ? textColorEnable : textColorDisable,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
