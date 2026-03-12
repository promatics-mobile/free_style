import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';

import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../../utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'change_password_cubit.dart';



class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            builder: (context, state) {
          var cubit = context.read<ChangePasswordCubit>();
          return Scaffold(
            backgroundColor: CommonColors.themeColor,
            appBar: CommonAppBar(
              title: "",
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(
                      text: "Change Password",
                      fontSize: size(context).width * numD07,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size(context).width * numD03),
                    CommonText(
                      text:
                      "Enter your current password and create a new password to update your account security.",
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
                            controller: cubit.currentController,
                            filled: true,
                            hint: "Current Password",
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

                              return null;
                            },
                          ),
                          SizedBox(
                            height: size(context).width * numD04,
                          ),

                          CommonTextFormField(
                            controller: cubit.newController,
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
                          SizedBox(
                            height: size(context).width * numD04,
                          ),

                          CommonTextFormField(
                            controller: cubit.confirmController,
                            filled: true,
                            hint: "Confirm Password",
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
                              } else if (!cubit.newController.text.equalsIgnoreCase(value)) {
                                return "Your confirm password does not match";
                              }

                              return null;
                            },
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: size(context).width * numD1),

                    CommonButton(onTap: (){
                      if(cubit.formKey.currentState!.validate()){
                        cubit.callChangePasswordApi();
                      }
                    }, text: "Change Password")


                  ],
                ),
              ),
            ),
          );
        }));
  }
}
