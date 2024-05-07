import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/image/app_images.dart';
import 'package:workmate/common/widget/base_page.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/ui/register/bloc/register_bloc.dart';
import 'package:workmate/ui/register/bloc/register_state.dart';
import 'package:workmate/ui/register/widget/register_password_input.dart';
import 'package:workmate/ui/register/widget/register_email_input.dart';
import 'package:workmate/ui/register/widget/register_button.dart';
import 'package:workmate/ui/register/widget/register_user_name_input.dart';

class RegisterAccountPage extends StatelessWidget {
  const RegisterAccountPage({Key? key}) : super(key: key);

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
      create: (context) => getIt<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == BlocStatus.success) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteDefine.home.name,
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: pageSize,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 97.h),
                  const Center(
                      child: Image(image: AssetImage(AppImages.loginHeader))),
                  const RegisterUserNameInput(),
                  SizedBox(height: 19.h),
                  const RegisterEmailInput(),
                  SizedBox(height: 13.h),
                  const RegisterPasswordInput(),
                  SizedBox(height: 43.h),
                  const RegisterButton()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
