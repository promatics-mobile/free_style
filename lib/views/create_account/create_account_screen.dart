import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/assets.dart';
import '../../main.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../../utils/common_widgets/text_form_field/common_text_form_field.dart';
import '../login/login_cubit.dart';
import 'create_account_cubit.dart';
import 'create_account_state.dart';

class CreateAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        var cubit = context.read<CreateAccountCubit>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: CommonColors.themeColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size(context).width * numD04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size(context).width * numD20),

                Center(
                  child: CommonText(
                    text: "Create Account",
                    fontSize: size(context).width * numD07,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: size(context).width * numD03),
                Center(
                  child: CommonText(
                    textSpan: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size(context).width * numD035,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: CommonColors.buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              router.pop();
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size(context).width * numD1),

                Container(
                  decoration: commonBgColorDecoration(
                    size(context).width * numD02,
                    Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.all(size(context).width * numD02),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            cubit.changeType(LoginType.email);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: size(context).width * numD03,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cubit.loginType == LoginType.email
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                size(context).width * numD02,
                              ),
                            ),
                            child: CommonText(
                              text: "Email",
                              fontSize: size(context).width * numD045,
                              fontWeight: FontWeight.w600,
                              color: cubit.loginType == LoginType.email
                                  ? CommonColors.themeColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: size(context).width * numD03),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            cubit.changeType(LoginType.phone);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: size(context).width * numD03,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cubit.loginType == LoginType.phone
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                size(context).width * numD02,
                              ),
                            ),
                            child: CommonText(
                              text: "Phone",
                              fontSize: size(context).width * numD045,
                              fontWeight: FontWeight.w600,
                              color: cubit.loginType == LoginType.phone
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size(context).width * numD08),

                Container(
                  decoration: commonBgColorDecoration(
                    size(context).width * numD02,
                    Colors.white,
                  ),
                  padding: EdgeInsets.all(size(context).width * numD02),
                  child: Column(
                    children: [
                      if (cubit.loginType == LoginType.email) ...[
                        CommonTextFormField(
                          controller: cubit.fullNameController,
                          filled: true,
                          enableShadow: true,
                          hint: "Full Name (optional)",
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: CommonColors.buttonColor,
                          ),
                        ),
                        Divider(),
                        CommonTextFormField(
                          controller: cubit.userNameController,
                          filled: true,
                          enableShadow: true,
                          hint: "Username",
                          keyboardType: TextInputType.text,

                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: CommonColors.buttonColor,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required*";
                            }
                            return null;
                          },
                        ),
                        Divider(),
                        CommonTextFormField(
                          controller: cubit.emailController,
                          filled: true,
                          enableShadow: true,
                          hint: "Email Address",
                          keyboardType: TextInputType.emailAddress,

                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: CommonColors.buttonColor,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required*";
                            }
                            /*if (!emailRegex.hasMatch(value.trim())) {
                                return t.valid_email_address;
                              }*/
                            return null;
                          },
                        ),
                        Divider(),
                        CommonTextFormField(
                          controller: cubit.passwordController,
                          filled: true,
                          enableShadow: true,
                          hint: "Password",
                          isPassword: true,
                          maxLength: 15,
                          counterText: "",

                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: CommonColors.buttonColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD03,
                            vertical: size(context).width * numD04,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required*";
                            }
                            return null;
                          },
                        ),
                        Divider(),
                        CommonTextFormField(
                          controller: cubit.confirmPasswordController,
                          filled: true,
                          enableShadow: true,
                          hint: "Confirm Password",
                          isPassword: true,
                          maxLength: 15,
                          counterText: "",

                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: CommonColors.buttonColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD03,
                            vertical: size(context).width * numD04,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required*";
                            }
                            return null;
                          },
                        ),
                      ],

                      if (cubit.loginType == LoginType.phone)
                        CommonTextFormField(
                          controller: cubit.phoneController,
                          filled: true,
                          enableShadow: true,
                          maxLength: cubit.phoneMaxLength,
                          keyboardType: TextInputType.phone,
                          hint: "Phone Number",
                          counterText: "",
                          maxLines: 1,

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
                              showCountryCodePickerDialog(
                                context,
                                onChanged: (country) {
                                  cubit.updateCountryCode(
                                    country.phoneCode ?? '',
                                  );
                                },
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: CommonText(
                                text: cubit.countryCode.isEmpty
                                    ? '+--'
                                    : cubit.countryCode,
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

                SizedBox(height: size(context).width * numD04),
                InkWell(
                  onTap: (){
                    cubit.onAgeSelected();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: .start,
                    children: [
                      Icon(
                        cubit.isAgeSelected
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        color: Colors.white,
                        size: size(context).width * numD06,
                      ),
                      SizedBox(width: size(context).width * numD02),
                      CommonText(
                        text: "I am at least 13 years old.",
                        fontSize: size(context).width * numD035,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size(context).width * numD02),
                InkWell(
                  onTap: () {
                    cubit.onAgreeTerms();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: .start,
                    children: [
                      Icon(
                        cubit.isTermsSelected
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        color: Colors.white,
                        size: size(context).width * numD06,
                      ),

                      SizedBox(width: size(context).width * numD02),
                      CommonText(
                        textSpan: TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: size(context).width * numD035,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  router.push(
                                    AppRouter.cmsScreen,
                                    extra: "Terms & Conditions",
                                  );
                                },
                            ),
                            TextSpan(
                              text: " and ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: "Privacy.",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  router.push(
                                    AppRouter.cmsScreen,
                                    extra: "Privacy Policy",
                                  );
                                },
                            ),
                          ],
                        ),
                        fontSize: size(context).width * numD035,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size(context).width * numD05),
                CommonButton(
                  onTap: () {
                    if(cubit.loginType == LoginType.phone){
                      router.push(AppRouter.otpVerificationScreen);
                    }else{
                      router.go(AppRouter.homeScreen);
                    }

                  },
                  text: "Register",
                ),
                SizedBox(height: size(context).width * numD1),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: size(context).width * numD005,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size(context).width * numD03,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          size(context).width * numD04,
                        ),
                      ),
                      child: CommonText(
                        text: "OR CONTINUE WITH",
                        fontSize: size(context).width * numD03,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: size(context).width * numD005,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size(context).width * numD05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: size(context).width * numD05),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: commonCircularBorder(
                          borderColor: Colors.white,
                          borderWidth: 1,
                        ),
                        padding: EdgeInsets.all(size(context).width * numD01),
                        child: CommonImage(
                          height: size(context).width * numD1,
                          width: size(context).width * numD1,
                          imagePath: Assets.iconsIcGoogleLogo,
                          isNetwork: false,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: commonCircularBorder(
                          borderColor: Colors.white,
                          borderWidth: 1,
                        ),
                        padding: EdgeInsets.all(size(context).width * numD01),
                        child: CommonImage(
                          height: size(context).width * numD1,
                          width: size(context).width * numD1,
                          imagePath: Assets.iconsIcAppleLogo,
                          isNetwork: false,
                        ),
                      ),
                    ),
                    SizedBox(width: size(context).width * numD05),
                  ],
                ),
                SizedBox(height: size(context).width * numD06),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCountryCodePickerDialog(
    BuildContext context, {
    required Function(Country) onChanged,
  }) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      useSafeArea: true,
      countryListTheme: CountryListThemeData(
        margin: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size(context).width * numD04),
          topRight: Radius.circular(size(context).width * numD04),
        ),
      ),
      onSelect: (Country country) {
        debugPrint('Select country: ${country.displayName}');
        onChanged(country);
      },
    );
  }
}
