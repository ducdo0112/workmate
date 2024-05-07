import 'package:workmate/generated/l10n.dart';
import 'package:workmate/utils/const.dart';
import 'package:workmate/utils/url_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsOfUseButton extends StatelessWidget {
  const TermsOfUseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  UrlLauncherHelper.launchInBrowser(
                      urlString: Const.urlTermOfUse);
                },
                child: Text(
                  S.current.term_of_use,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                S.current.and,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  UrlLauncherHelper.launchInBrowser(
                      urlString: Const.urlPrivacy);
                },
                child: Text(
                  S.current.privacy_policy,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
