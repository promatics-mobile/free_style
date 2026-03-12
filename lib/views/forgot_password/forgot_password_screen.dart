import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';

import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../../utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'forgot_password_cubit.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        var cubit = context.read<ForgotPasswordCubit>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: CommonColors.themeColor,
          appBar: CommonAppBar(
            title: "",
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size(context).width*numD04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: "Forgot Password",
                  fontSize: size(context).width * numD07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size(context).width * numD03,
                ),
                CommonText(
                  text: "Don't worry! It happens. Please enter the email address linked to your account.",
                  fontSize: size(context).width * numD035,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size(context).width * numD15,
                ),




                CommonTextFormField(
                  controller: cubit.emailController,
                  hint: "you@example.com",
                  filled: true,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      size(context).width * numD025,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD04,
                      vertical: size(context).width * numD04),
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: size(context).width * numD04),
                      child: Icon(Icons.email_outlined, color: CommonColors.buttonColor,)),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return "Required*";
                    }
                    if (!emailRegex.hasMatch(value.trim())) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size(context).width * numD04,
                ),




                SizedBox(
                  height: size(context).width * numD04,
                ),

                CommonButton(onTap: (){
                  if(cubit.emailController.text.isNotEmpty){
                    cubit.callForgotPasswordApi();
                  }
                },  text: "Send Code",

                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
