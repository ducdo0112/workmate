import 'package:workmate/common/color/color_scheme_extension.dart';
import 'package:flutter/material.dart';

class InputView extends StatelessWidget {
  final TextInputType inputType;
  final Widget? icon;
  final String hideText;
  final TextEditingController controller;
  final bool obscureText;

  const InputView(
      {Key? key,
      this.inputType = TextInputType.multiline,
      this.hideText = '',
      this.icon,
      required this.controller,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextField(
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyText2,
        controller: controller,
        decoration: InputDecoration(
          labelText: hideText,
          labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).black),
          contentPadding: EdgeInsets.zero,
          focusColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).defaultTextColorLostFocus),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).defaultTextColor),
          ),
        ),
        cursorColor: Theme.of(context).defaultTextColor,
      ),
    );
  }
}
