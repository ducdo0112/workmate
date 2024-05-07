import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/image/app_images.dart';
import 'package:workmate/common/widget/base_page.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/ui/login/bloc/login_bloc.dart';
import 'package:workmate/ui/login/bloc/login_state.dart';
import 'package:workmate/ui/login/widget/header_title.dart';
import 'package:workmate/ui/login/widget/login_button.dart';
import 'package:workmate/ui/login/widget/password_input.dart';
import 'package:workmate/ui/login/widget/start_gift_button.dart';
import 'package:workmate/ui/login/widget/terms_of_use_button.dart';
import 'package:workmate/ui/login/widget/email_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBasePage(
      appBar: _buildAppBar(),
      backgroundColor: AppColor.white,
      extendBodyBehindAppBar: true,
      showDrawer: false,
      resizeToAvoidBottomInset: false,
      body: _buildBodyWidget(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    final pageSize = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state.status == BlocStatus.success) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteDefine.home.name,
              (Route<dynamic> route) => false,
            );
          }
        },
        child: SizedBox(
          height: pageSize,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 97.h),
                const Center(
                    child: Image(image: AssetImage(AppImages.loginHeader))),
                SizedBox(height: 19.h),
                const EmailCodeInput(),
                SizedBox(height: 13.h),
                const PasswordInput(),
                SizedBox(height: 43.h),
                const LoginButton(),
                SizedBox(height: 13.h),
                const StartGiftButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
