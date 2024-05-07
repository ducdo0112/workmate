import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/image/app_images.dart';
import 'package:workmate/utils/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputFormWithTypeSelect extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hint;
  final double? borderRadius;
  final double? borderSideWidth;
  final Color? borderSideColor;
  final bool obscureText;
  final TextInputType? textInputType;
  final int? maxLength;
  final Color cursorColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final bool enable;
  final double contentPaddingTop;
  final double contentPaddingBottom;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double? fontSize;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final List<String> dropDownValues;
  final String? initValue;
  final double menuHeight;
  final Function(int)? indexSelectedAction;

  const InputFormWithTypeSelect({
    Key? key,
    required this.dropDownValues,
    this.controller,
    this.onChanged,
    this.hint = '',
    this.borderRadius,
    this.borderSideWidth,
    this.borderSideColor,
    this.obscureText = false,
    this.textInputType,
    this.maxLength,
    this.enable = true,
    this.cursorColor = Colors.black,
    this.inputFormatters,
    this.hintTextStyle,
    this.textStyle,
    this.contentPaddingTop = 20,
    this.contentPaddingBottom = 16,
    this.contentPaddingLeft = 16,
    this.contentPaddingRight = 0.0,
    this.fontSize,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.menuHeight = 200,
    this.indexSelectedAction,
    this.initValue,
  }) : super(key: key);

  @override
  State<InputFormWithTypeSelect> createState() =>
      _InputFormWithTypeSelectState();
}

class _InputFormWithTypeSelectState extends State<InputFormWithTypeSelect> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<String>(
          initialSelection: widget.initValue,
          width: constraints.maxWidth,
          menuStyle: MenuStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)))),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: AppColor.white,
              contentPadding: EdgeInsets.only(
                left: widget.contentPaddingLeft,
                right: widget.contentPaddingRight,
                top: widget.contentPaddingTop,
                bottom: widget.contentPaddingBottom,
              ),
              hintStyle: widget.hintTextStyle,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 30.w),
                borderSide: BorderSide(
                    width: widget.borderSideWidth ?? 1,
                    style: BorderStyle.solid,
                    color: widget.borderSideColor ?? AppColor.orangePeel),
              ),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 30.w),
                borderSide: BorderSide(
                    width: widget.borderSideWidth ?? 1,
                    style: BorderStyle.solid,
                    color: widget.borderSideColor ?? AppColor.orangePeel),
              )),
          textStyle: widget.textStyle,
          hintText: widget.hint,
          menuHeight: widget.menuHeight,
          trailingIcon: Align(
            widthFactor: 1,
            heightFactor: 1,
            child: SvgPicture.asset(
              AppImages.addressRegister,
              width: 16.25.w,
              height: 16.25.h,
              colorFilter: widget.borderSideColor != null
                  ? ColorFilter.mode(widget.borderSideColor!, BlendMode.srcIn)
                  : const ColorFilter.mode(
                      AppColor.darkTangerine, BlendMode.srcIn),
            ),
          ),
          onSelected: (String? value) {
            hideKeyboard();
            widget.indexSelectedAction
                ?.call(widget.dropDownValues.indexOf(value ?? ''));
          },
          dropdownMenuEntries: widget.dropDownValues
              .map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
}
