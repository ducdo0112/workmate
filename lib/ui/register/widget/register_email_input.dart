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

class RegisterEmailInput extends StatelessWidget {
  const RegisterEmailInput({Key? key}) : super(key: key);

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
                  AppImages.email,
                  colorFilter: const ColorFilter.mode(
                      AppColor.textColorSilver, BlendMode.srcIn),
                ),
              ),
              prefixIconConstraints:
                  BoxConstraints(minWidth: 22.w, minHeight: 22.w),
              borderSideWidth: 1.0,
              onChanged: (value) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterEmailEventChanged(email: value));
              },
              hint: "Email",
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            Visibility(
                visible: state.isErrorInputEmail,
                child: Text(
                  "Email không được trống và phải đúng định dạng",
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
