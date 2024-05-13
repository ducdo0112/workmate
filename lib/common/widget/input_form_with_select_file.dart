import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFormWithSelectFile extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<FilePickerResult> onChanged;
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
  final String? fileNameInit;
  final String? linkFileInit;

  const InputFormWithSelectFile(
      {Key? key,
      this.controller,
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
      this.fileNameInit,
      this.linkFileInit,
      required this.onChanged})
      : super(key: key);

  @override
  State<InputFormWithSelectFile> createState() =>
      _InputFormWithSelectFileState();
}

class _InputFormWithSelectFileState extends State<InputFormWithSelectFile> {
  @override
  Widget build(BuildContext context) {
    if (widget.fileNameInit != null &&
        (widget.fileNameInit?.isNotEmpty ?? false)) {
      widget.controller?.text = widget.fileNameInit ?? '';
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
        suffixIcon: GestureDetector(
          onTap: () async {
            if (widget.linkFileInit != null &&
                (widget.linkFileInit?.isNotEmpty ?? false)) {
              String url = widget.linkFileInit ?? '';
              await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            }
          },
          child: widget.suffixIcon,
        ),
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
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);

        if (result != null) {
          // File file = File(result.files.single.path!);
          // Uint8List? fileBytes = result.files.first.bytes;
          String fileName = result.files.first.name;
          widget.onChanged.call(result);
          widget.controller?.text = fileName;
        } else {
          // User canceled the picker
        }
      },
    );
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
}
