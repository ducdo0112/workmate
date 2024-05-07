import 'package:workmate/common/color/app_color.dart';
import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({
    Key? key,
    this.color = AppColor.orangePeel,
    this.size,
  }) : super(key: key);
  final Color color;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: size != null
          ? SizedBox(
              width: size!.width,
              height: size!.height,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color,
              ),
            )
          : CircularProgressIndicator(
              color: color,
            ),
    );
  }
}
