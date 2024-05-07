import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:workmate/ui/register/bloc/register_bloc.dart';
import 'package:workmate/ui/register/bloc/register_state.dart';

class RegisterUserNameInput extends StatelessWidget {
  const RegisterUserNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputForm(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  AppImages.user,
                  colorFilter: const ColorFilter.mode(
                    AppColor.textColorSilver,
                    BlendMode.srcIn,
                  ),
                  width: 20.w,
                  height: 20.w,
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 20.w,
                minHeight: 20.w,
              ),
              borderSideWidth: 1.0,
              onChanged: (value) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterUserNameEventChanged(userName: value));
              },
              hint: "Họ tên",
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color: AppColor.quickSilver,
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            Visibility(
                visible: state.isErrorInputUsername,
                child: Text(
                  "Username không được để trống",
                  style: TextStyle(
                      color: AppColor.red,
                      fontSize: 10.sp,
                      fontStyle: FontStyle.italic),
                )),
          ],
        );
      },
    );
  }
}
