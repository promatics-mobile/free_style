import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_widgets.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  late LogInCubit cubit;
  late LogInState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        cubit = context.read<LogInCubit>();
        this.state = state;
        return Scaffold(
          backgroundColor: CommonColors.themeColor,
          body: Column(
            children: [
              SizedBox(height: size(context).width * numD30),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD04,
                    ),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonText(
                            text: "Login",
                            fontSize: size(context).width * numD07,
                            fontWeight: FontWeight.bold,
                          ),

                          SizedBox(height: size(context).width * numD03),
                          CommonText(
                            textSpan: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size(context).width * numD035,
                              ),
                              children: [
                                TextSpan(
                                  text: "Create Account",
                                  style: TextStyle(
                                      color: CommonColors.buttonColor,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      router.push(
                                        AppRouter.createAccountScreen,
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: size(context).width * numD1),

                          Container(
                            decoration: commonBgColorDecoration(
                              size(context).width * numD02,
                              Colors.grey.shade200,
                            ),
                            padding: EdgeInsets.all(
                              size(context).width * numD02,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.changeLoginType(LoginType.email);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: size(context).width * numD03,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            cubit.loginType == LoginType.email
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
                                        color:
                                            cubit.loginType == LoginType.email
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
                                      cubit.changeLoginType(LoginType.phone);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: size(context).width * numD03,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            cubit.loginType == LoginType.phone
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
                                        color:
                                            cubit.loginType == LoginType.phone
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
                            padding: EdgeInsets.all(
                              size(context).width * numD02,
                            ),
                            child: Column(
                              children: [
                                if (cubit.loginType == LoginType.email)
                                  CommonTextFormField(
                                    controller: cubit.emailController,
                                    filled: true,
                                    enableShadow: true,
                                    hint: "Enter Email Address",
                                    keyboardType: TextInputType.emailAddress,

                                    prefixIcon: Icon(Icons.email_outlined,color: CommonColors.buttonColor,),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Required*";
                                      }
                                      /*if (!emailRegex.hasMatch(value.trim())) {
                                  return t.valid_email_address;
                                }*/
                                      return null;
                                    },
                                  ),

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
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Required*";
                                      }

                                      final phone = value.trim();

                                      if (!RegExp(
                                        r'^[0-9]+$',
                                      ).hasMatch(phone)) {
                                        return "Please enter a valid mobile number";
                                      }

                                      if (phone.length < 6 ||
                                          phone.length > 15) {
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
                                          fontSize:
                                              size(context).width * numD035,
                                          color: CommonColors.themeColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),

                                if (cubit.loginType == LoginType.email) ...[
                                  Divider(),
                                  CommonTextFormField(
                                    controller: cubit.passwordController,
                                    filled: true,
                                    enableShadow: false,
                                    hint: "Enter Password",
                                    isPassword: true,

                                    prefixIcon: Icon(Icons.lock_outline,color: CommonColors.buttonColor,),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: size(context).width * numD03,
                                        vertical: size(context).width * numD04),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "Required*";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),

                          if (cubit.loginType == LoginType.email) ...[
                            SizedBox(height: size(context).width * numD04),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  router.push(AppRouter.forgotPasswordScreen);
                                },
                                child: CommonText(
                                  text: "Forgot Password?",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: size(context).width * numD035,
                                ),
                              ),
                            ),
                          ],

                          SizedBox(height: size(context).width * numD10),

                          CommonButton(
                            onTap: () {
                              if(cubit.loginType == LoginType.phone){
                                router.push(AppRouter.otpVerificationScreen);
                              }else{
                                router.go(AppRouter.dashboardScreen, extra: 0);
                              }

                            },
                            text: cubit.loginType == LoginType.email
                                ? "Login"
                                : "Send OTP",
                          ),

                          SizedBox(height: size(context).width * numD1),

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: size(context).width * numD005,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
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
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
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
                                  padding: EdgeInsets.all(
                                    size(context).width * numD01,
                                  ),
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
                                  padding: EdgeInsets.all(
                                    size(context).width * numD01,
                                  ),
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
                  ),
                ),
              ),
            ],
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
