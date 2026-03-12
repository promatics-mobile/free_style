import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:free_style/views/reset_password/reset_password_cubit.dart';
import 'package:free_style/views/reset_password/reset_password_state.dart';

import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ResetPasswordScreen extends StatelessWidget {
  int selectedRole = 0;

  ResetPasswordScreen({super.key});

  late ResetPasswordCubit cubit;
  late ResetPasswordState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        cubit = context.read<ResetPasswordCubit>();
        this.state = state;
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: CommonColors.themeColor,
          resizeToAvoidBottomInset: false,
          appBar: CommonAppBar(title: ""),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size(context).width * numD04,
            ),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: "Reset Password",
                    fontSize: size(context).width * numD07,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size(context).width * numD03),
                  CommonText(
                    text:
                        "Enter the verification code sent to your email and create a new password",
                    fontSize: size(context).width * numD035,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: size(context).width * numD10),

                  Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD02,
                      Colors.white,
                    ),
                    padding: EdgeInsets.all(size(context).width * numD02),
                    child: Column(
                      children: [
                        CommonTextFormField(
                          controller: cubit.otpController,
                          filled: true,
                          hint: "Enter OTP",
                          isPassword: true,
                          maxLines: 1,
                          maxLength: 4,
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD03,
                            vertical: size(context).width * numD04,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              left: size(context).width * numD03,
                              right: size(context).width * numD03,
                            ),
                            child: Icon(
                              Icons.lock_outline,
                              color: CommonColors.buttonColor,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required*";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: size(context).width * numD04),
                        CommonTextFormField(
                          controller: cubit.newPasswordController,
                          filled: true,
                          hint: "New Password",
                          isPassword: true,
                          maxLines: 1,
                          maxLength: 15,
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD03,
                            vertical: size(context).width * numD04,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              left: size(context).width * numD03,
                              right: size(context).width * numD03,
                            ),
                            child: Icon(
                              Icons.lock_outline,
                              color: CommonColors.buttonColor,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required*";
                            }

                            if (value.length < 8) {
                              return "Password should be at least 8 characters";
                            }

                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return "Password should contain at least one uppercase letter";
                            }

                            if (!RegExp(r'[a-z]').hasMatch(value)) {
                              return "Password should contain at least one lowercase letter";
                            }

                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return "Password should contain at least one number";
                            }

                            if (!RegExp(
                              r'[!@#$%^&*(),.?":{}|<>]',
                            ).hasMatch(value)) {
                              return "Password should contain at least one special character";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: size(context).width * numD04),
                        CommonTextFormField(
                          controller: cubit.confirmPasswordController,
                          filled: true,
                          hint: "Confirm Password",
                          isPassword: true,
                          maxLines: 1,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD03,
                            vertical: size(context).width * numD04,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              left: size(context).width * numD03,
                              right: size(context).width * numD03,
                            ),
                            child: Icon(
                              Icons.lock_outline,
                              color: CommonColors.buttonColor,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required*";
                            }

                            if (value.trim() !=
                                cubit.newPasswordController.text.trim()) {
                              return "Password does not match";
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size(context).width * numD1),

                  CommonButton(
                    text: "Reset Password",
                    onTap: () {
                       if (cubit.formKey.currentState!
                          .validate()) {
                        cubit.callResetPasswordAPI();
                      }
                    },
                  ),
                  SizedBox(height: size(context).width * numD06),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
