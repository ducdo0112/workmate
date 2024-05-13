import 'package:workmate/common/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmate/ui/events/widget/select_user.dart';

import '../../../model/user/user_info_data.dart';

class InputFormWithAddUser extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
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
  final List<UserInfoData> userSelected;
  final List<UserInfoData> listUserInfo;
  final Function(List<UserInfoData>) onUserSelectedCompleted;
  final String? textInit;

  const InputFormWithAddUser({
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
    required this.userSelected,
    required this.listUserInfo,
    required this.onUserSelectedCompleted,
    this.textInit,
  }) : super(key: key);

  @override
  State<InputFormWithAddUser> createState() => _InputFormWithAddUserState();
}

class _InputFormWithAddUserState extends State<InputFormWithAddUser> {
  @override
  Widget build(BuildContext context) {
    if (widget.textInit != null &&
        (widget.textInit?.isNotEmpty ?? false)) {
      widget.controller?.text = widget.textInit ?? '';
    }
    return TextFormField(
      textAlign: widget.textAlign,
      enabled: widget.enable,
      maxLength: widget.maxLength,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
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
      cursorColor: Colors.transparent,
      showCursor: false,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        List<UserInfoData> listUserSelected = [...widget.userSelected];
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text("Thêm hoặc xoá người dùng"),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SelectUser(
                    listUserInfo: widget.listUserInfo,
                    userSelected: widget.userSelected,
                    selectUserChange: (List<UserInfoData> listUserSelected1) {
                      listUserSelected = listUserSelected1;
                    },
                  ),
                )
              ],
            );
          },
        ).then((value) {
          widget.onUserSelectedCompleted.call(listUserSelected);
        });
      },
    );
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

}
