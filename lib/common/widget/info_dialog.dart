import 'package:workmate/common/color/app_color.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    Key? key,
    required this.content,
    required this.textButtonAction,
    this.action,
    this.title,
  }) : super(key: key);
  final String? title;
  final String content;
  final String textButtonAction;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(
            textButtonAction,
            style: const TextStyle(color: AppColor.yellowOrange),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            action?.call();
          },
        ),
      ],
    );
  }
}
