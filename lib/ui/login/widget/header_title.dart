import 'package:workmate/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.current.login_header_gif,
      style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w600),
    );
  }
}
