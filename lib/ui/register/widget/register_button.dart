import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/widget/custom_button.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:workmate/ui/login/bloc/login_bloc.dart';
import 'package:workmate/ui/login/bloc/login_event.dart';
import 'package:workmate/ui/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmate/ui/register/bloc/register_bloc.dart';
import 'package:workmate/ui/register/bloc/register_state.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CustomButton(
          buttonStatus: state.status,
          title: "Đăng ký tài khoản",
          buttonClick: () {
            context.read<RegisterBloc>().add(const RegisterButtonPressed());
          },
          fontSize: 16.sp,
          borderSizeWidth: 3.w,
          backgroundColorEnable: AppColor.yellowOrange,
          borderSizeColor: AppColor.yellowOrange,
          isEnable: true,
        );
      },
    );
  }
}
