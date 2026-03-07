import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';

import '../../utils/common_constants.dart';
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
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              title: "Change Password",
            ),
            body: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD04,
                  vertical: size(context).width * numD02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                      text: "Current Password",
                      fontSize: size(context).width * numD035),
                  CommonTextFormField(
                    controller: cubit.currentController,
                    hint: "Enter Current Password",
                    borderColor: CommonColors.lightGreyColor,
                    isPassword: cubit.currentPass,
                    suffixIcon: InkWell(
                        onTap: () {
                          cubit.currentPassFn();
                        },
                        child: Icon(
                          cubit.currentPass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: CommonColors.secondaryColor,
                        )),
                  ),
                  SizedBox(
                    height: size(context).width * numD04,
                  ),
                  CommonText(
                      text: "New Password",
                      fontSize: size(context).width * numD035),
                  CommonTextFormField(
                    controller: cubit.newController,
                    hint: "Enter New Password",
                    borderColor: CommonColors.lightGreyColor,
                    isPassword: cubit.newPass,
                    suffixIcon: InkWell(
                        onTap: () {
                          cubit.newPassFn();
                        },
                        child: Icon(
                          cubit.newPass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: CommonColors.secondaryColor,
                        )),
                  ),
                  SizedBox(
                    height: size(context).width * numD04,
                  ),
                  CommonText(
                      text: "Confirm Password",
                      fontSize: size(context).width * numD035),
                  CommonTextFormField(
                    hint: "Confirm Password",
                    controller: cubit.confirmController,
                    borderColor: CommonColors.lightGreyColor,
                    isPassword: cubit.confirmPass,
                    suffixIcon: InkWell(
                        onTap: () {
                          cubit.confirmPassFn();
                        },
                        child: Icon(
                          cubit.confirmPass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: CommonColors.secondaryColor,
                        )),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      cubit.onSubmitFn();
                      showToast(
                          isError: false,
                          message: "Password Changed Successfully");
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size(context).width * numD03),
                      width: size(context).width,
                      height: size(context).width * numD12,
                      alignment: Alignment.center,
                      child: CommonText(
                        text: "Submit",
                        fontSize: size(context).width * numD04,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
