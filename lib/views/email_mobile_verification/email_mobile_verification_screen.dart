import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:free_style/views/dashboard/dashboard_cubit.dart';
import 'package:free_style/views/email_mobile_verification/email_mobile_verification_cubit.dart';

import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/common_country_picker/common_country_picker.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class EmailMobileVerificationScreen extends StatelessWidget {
  const EmailMobileVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailMobileVerificationCubit, EmailMobileVerificationState>(
      builder: (context, state) {
        var cubit = context.read<EmailMobileVerificationCubit>();
        return Scaffold(
          appBar: CommonAppBar(title: "Verification"),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              children: [
                Text("Email Verification"),
                CommonTextFormField(
                  controller: cubit.emailController,
                  filled: true,
                  enableShadow: true,
                  readOnly: context.read<DashboardCubit>().userModel!.isEmailVerified!,
                  hint: "Enter Email Address",
                  keyboardType: TextInputType.emailAddress,
                  borderRadius: BorderRadius.all(Radius.circular(size(context).width * numD025)),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: size(context).width * numD04),
                    child: Icon(Icons.email_outlined, color: CommonColors.buttonColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size(context).width * numD04,
                    vertical: size(context).width * numD04,
                  ),
                  suffixIcon: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size(context).width * numD02,
                      horizontal: size(context).width * numD02,
                    ),
                    child: commonShortButton(
                      onTap: () {
                        hideKeyboard(context);
                        if (context.read<DashboardCubit>().userModel!.isEmailVerified!) {
                          return;
                        }
                        if (cubit.emailController.text.isNotEmpty) {
                          cubit.callEmailVerifyApi("email");
                        }
                      },
                      buttonColor: context.watch<DashboardCubit>().userModel!.isEmailVerified!
                          ? Colors.green
                          : null,
                      size: size(context),
                      buttonText: context.watch<DashboardCubit>().userModel!.isEmailVerified!
                          ? "Verified"
                          : "Verify",
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required*";
                    }
                    if (!emailRegex.hasMatch(value.trim())) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                Text("Mobile Verification"),
                CommonTextFormField(
                  controller: cubit.phoneController,
                  filled: true,
                  enableShadow: true,
                  maxLength: cubit.phoneMaxLength,
                  keyboardType: TextInputType.phone,
                  hint: "Phone Number",
                  counterText: "",
                  maxLines: 1,
                  readOnly: context.read<DashboardCubit>().userModel!.isMobileVerified!,
                  borderRadius: BorderRadius.all(Radius.circular(size(context).width * numD025)),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size(context).width * numD04,
                    vertical: size(context).width * numD04,
                  ),
                  suffixIcon: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size(context).width * numD02,
                      horizontal: size(context).width * numD02,
                    ),
                    child: commonShortButton(
                      onTap: () {
                        hideKeyboard(context);
                        if (context.read<DashboardCubit>().userModel!.isMobileVerified!) {
                          return;
                        }

                        if (cubit.phoneController.text.isNotEmpty) {
                          cubit.callEmailVerifyApi("phone");
                        }
                      },
                      buttonColor: context.watch<DashboardCubit>().userModel!.isMobileVerified!
                          ? Colors.green
                          : null,
                      size: size(context),
                      buttonText: context.watch<DashboardCubit>().userModel!.isMobileVerified!
                          ? "Verified"
                          : "Verify",
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required*";
                    }

                    final phone = value.trim();

                    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
                      return "Please enter a valid mobile number";
                    }

                    if (phone.length < 6 || phone.length > 15) {
                      return "Please enter a valid mobile number";
                    }

                    return null;
                  },

                  prefixIcon: GestureDetector(
                    onTap: () async {
                      hideKeyboard(context);
                      showCountryCodePickerDialog(
                        context,
                        onChanged: (country) {
                          cubit.updateCountryCode(country.phoneCode ?? '');
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: CommonText(
                        text: cubit.countryCode.isEmpty ? '+--' : cubit.countryCode,
                        fontSize: size(context).width * numD035,
                        color: CommonColors.themeColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
