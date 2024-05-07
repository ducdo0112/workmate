import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/image/app_images.dart';
import 'package:workmate/common/widget/base_page.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class InAppWebViewPage extends StatefulWidget {
  const InAppWebViewPage({Key? key, this.args}) : super(key: key);
  final InAppWebViewPageArgs? args;

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  //late WebViewController controller;

  @override
  void initState() {
    super.initState();
    _initConfigWebView();
  }

  _initConfigWebView() {
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(AppColor.white)
    //   ..loadRequest(Uri.parse(widget.args?.url ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return buildBasePage(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      resizeToAvoidBottomInset: false,
      body:
          _buildBodyWidget(context: context, statusBarHeight: statusBarHeight),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ));
  }

  _buildNavigationButton() {
    return Row(
      children: [
        SizedBox(
          width: 40.w,
        ),
        SvgPicture.asset(AppImages.webViewActionBack),
        SizedBox(
          width: 108.w,
        ),
        SvgPicture.asset(AppImages.webViewActionNext)
      ],
    );
  }

  _buildDoneButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.w),
        child: Text(
          S.current.completed,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w300,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }

  _buildBodyWidget(
      {required BuildContext context, required double statusBarHeight}) {
    return Column(
      children: [
        _buildCustomAppBar(context: context, statusBarHeight: statusBarHeight),
        Expanded(child: Container())
      ],
    );
  }

  PreferredSizeWidget _buildCustomAppBar(
      {required BuildContext context, required double statusBarHeight}) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Set this height
        child: Container(
          margin: EdgeInsets.only(top: statusBarHeight),
          height: kTextTabBarHeight,
          color: AppColor.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildNavigationButton(), _buildDoneButton(context)],
          ),
        ));
  }
}

class InAppWebViewPageArgs {
  const InAppWebViewPageArgs({required this.url});

  final String url;
}
