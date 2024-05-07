import 'package:workmate/common/color/app_color.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.content,
    this.textPositiveButton,
    this.textNegativeButton,
    this.actionNegative,
    this.actionPositive,
  }) : super(key: key);
  final String content;
  final String? textPositiveButton;
  final VoidCallback? actionPositive;
  final String? textNegativeButton;
  final VoidCallback? actionNegative;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Text(content ?? ''),
      actions: <Widget>[
        if (textNegativeButton != null)
          TextButton(
            child: Text(textNegativeButton ?? '',
                style: const TextStyle(color: AppColor.yellowOrange)),
            onPressed: () {
              actionNegative?.call();
              Navigator.of(context).pop();
            },
          ),
        if (textPositiveButton != null)
          TextButton(
            child: Text(
              textPositiveButton ?? '',
              style: const TextStyle(color: AppColor.yellowOrange),
            ),
            onPressed: () {
              actionPositive?.call();
              Navigator.of(context).pop();
            },
          ),
      ],
    );
  }
}
