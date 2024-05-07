import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/widget/custom_button.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:workmate/ui/login/bloc/login_bloc.dart';
import 'package:workmate/ui/login/bloc/login_event.dart';
import 'package:workmate/ui/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CustomButton(
          title: S.current.login,
          buttonStatus: state.status,
          buttonClick: () {
            context.read<LoginBloc>().add(const LoginEventPressed());
          },
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          textColorEnable: AppColor.black,
          borderSizeColor: AppColor.black,
          borderSizeWidth: 1.w,
          circularProgressColor: AppColor.orangePeel,
          backgroundColorEnable: AppColor.white,
          isEnable: true,
        );
      },
    );
  }
}
