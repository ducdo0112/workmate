import 'package:workmate/common/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFormWithTimePicker extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<TimeOfDay>? onChanged;
  final String hint;
  final double? borderRadius;
  final bool isBorderLeft;
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
  final double? contentPaddingTop;
  final double? contentPaddingBottom;
  final double? contentPaddingLeft;
  final double? contentPaddingRight;
  final double? fontSize;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final InputBorder? disabledBorder;

  const InputFormWithTimePicker({
    Key? key,
    this.controller,
    this.onChanged,
    this.hint = '',
    this.borderRadius,
    this.isBorderLeft = false,
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
    this.contentPaddingTop,
    this.contentPaddingBottom,
    this.contentPaddingLeft,
    this.contentPaddingRight,
    this.fontSize,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.disabledBorder,
    this.prefixIcon,
    this.prefixIconConstraints,
  }) : super(key: key);

  @override
  State<InputFormWithTimePicker> createState() =>
      _InputFormWithTimePickerState();
}

class _InputFormWithTimePickerState extends State<InputFormWithTimePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      enabled: widget.enable,
      maxLength: widget.maxLength,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      onChanged: (value) {

      },
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.enable ? Colors.white : Colors.black12,
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints: widget.suffixIconConstraints,
        prefixIconConstraints: widget.prefixIconConstraints,
        disabledBorder: OutlineInputBorder(
          borderRadius: widget.isBorderLeft
              ? BorderRadius.only(
                  topLeft: Radius.circular(widget.borderRadius ?? 6.w),
                  bottomLeft: Radius.circular(widget.borderRadius ?? 6.w))
              : BorderRadius.circular(widget.borderRadius ?? 6.w),
          borderSide: widget.borderSideWidth != null
              ? BorderSide(
                  width: widget.borderSideWidth ?? 1,
                  style: BorderStyle.solid,
                  color: widget.borderSideColor ?? AppColor.gray)
              : BorderSide.none,
        ),
        suffixIcon: widget.suffixIcon,
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.isBorderLeft
              ? BorderRadius.only(
                  topLeft: Radius.circular(widget.borderRadius ?? 6.w),
                  bottomLeft: Radius.circular(widget.borderRadius ?? 6.w))
              : BorderRadius.circular(widget.borderRadius ?? 6.w),
          borderSide: widget.borderSideWidth != null
              ? BorderSide(
                  width: widget.borderSideWidth ?? 1,
                  style: BorderStyle.solid,
                  color: widget.borderSideColor ?? AppColor.gray)
              : BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: widget.isBorderLeft
              ? BorderRadius.only(
                  topLeft: Radius.circular(widget.borderRadius ?? 6.w),
                  bottomLeft: Radius.circular(widget.borderRadius ?? 6.w))
              : BorderRadius.circular(widget.borderRadius ?? 6.w),
          borderSide: widget.borderSideWidth != null
              ? BorderSide(
                  width: widget.borderSideWidth ?? 1,
                  style: BorderStyle.solid,
                  color: widget.borderSideColor ?? AppColor.gray)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: widget.isBorderLeft
              ? BorderRadius.only(
                  topLeft: Radius.circular(widget.borderRadius ?? 6.w),
                  bottomLeft: Radius.circular(widget.borderRadius ?? 6.w))
              : BorderRadius.circular(widget.borderRadius ?? 6.w),
          borderSide: widget.borderSideWidth != null
              ? BorderSide(
                  width: widget.borderSideWidth ?? 1,
                  style: BorderStyle.solid,
                  color: widget.borderSideColor ?? AppColor.gray)
              : BorderSide.none,
        ),
        hintText: widget.hint,
        hintStyle: widget.hintTextStyle,
        contentPadding: EdgeInsets.only(
            left: widget.contentPaddingLeft ?? 20.w,
            right: widget.contentPaddingRight ?? 20.w,
            top: widget.contentPaddingTop ?? 12.w,
            bottom: widget.contentPaddingBottom ?? 8.w),
      ),
      obscureText: widget.obscureText,
      style: widget.textStyle,
      cursorColor: widget.cursorColor,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        TimeOfDay? selectedTime = await showTimePicker(
          initialEntryMode: TimePickerEntryMode.dialOnly,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          },
          initialTime: TimeOfDay.now(),
          context: context,
          helpText: "Chọn giờ",
          cancelText: "Huỷ bỏ",
        );
        widget.onChanged?.call(selectedTime ?? TimeOfDay.now());
      },
    );
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
}
