import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/image/app_images.dart';
import 'package:workmate/common/widget/input_form.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:workmate/ui/login/bloc/login_bloc.dart';
import 'package:workmate/ui/login/bloc/login_event.dart';
import 'package:workmate/ui/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputForm(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  AppImages.password,
                  colorFilter: const ColorFilter.mode(
                      AppColor.textColorSilver, BlendMode.srcIn),
                  width: 20.w,
                  height: 20.w,
                ),
              ),
              prefixIconConstraints:
                  BoxConstraints(minWidth: 20.w, minHeight: 20.w),
              obscureText: !state.isShowPassword,
              borderSideWidth: 1.0,
              onChanged: (value) {
                context
                    .read<LoginBloc>()
                    .add(LoginEventPasswordChanged(password: value));
              },
              hint: S.current.password,
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color: AppColor.quickSilver,
                fontWeight: FontWeight.bold,
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
              suffixIconConstraints:
                  BoxConstraints(minWidth: 24.w, minHeight: 24.w),
              suffixIcon: _buildShowHideIconPassword(state, context),
            ),
            Visibility(
                visible: state.isErrorInputPassword,
                child: Text(
                  "Password không được để trống",
                  style: TextStyle(
                      color: AppColor.red,
                      fontSize: 10.sp,
                      fontStyle: FontStyle.italic),
                ))
          ],
        );
      },
    );
  }

  _buildShowHideIconPassword(LoginState state, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        child: GestureDetector(
          onTap: () {
            context
                .read<LoginBloc>()
                .add(const LoginEventShowHidePassChanged());
          },
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: SvgPicture.asset(
              state.isShowPassword ? AppImages.eyeHide : AppImages.eyeNotHide,
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
