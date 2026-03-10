import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../routes/route.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'otp_verification_cubit.dart';
import 'otp_verification_state.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  late OtpVerificationCubit cubit;
  late OtpVerificationState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
      builder: (context, state) {
        cubit = context.read<OtpVerificationCubit>();
        this.state = state;
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: CommonColors.themeColor,
          appBar: CommonAppBar(
            title: "",
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size(context).width * numD04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CommonText(
                  text: "OTP Verification",
                  fontSize: size(context).width * numD07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size(context).width * numD03,
                ),



                if(!cubit.isFromSignIn || cubit.isFromForgotPassword)
                CommonText(
                  text: "Enter the OTP code sent to your email \n(${cubit.email})",
                  fontSize: size(context).width * numD035,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),


                if(!cubit.isFromForgotPassword)
                CommonText(
                  text: "Enter the OTP code sent to your phone \n(${cubit.phone})",
                  fontSize: size(context).width * numD035,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: size(context).width * numD1),

                Container(
                  padding: EdgeInsets.all(size(context).width * numD02),
                  decoration: commonBgColorDecoration(size(context).width * numD02, Colors.white),
                  child:  Container(
                    margin: EdgeInsets.only(top:size(context).width * numD04),
                    decoration: commonBgColorDecoration(size(context).width * numD02, Colors.white),
                    child: PinCodeTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cubit.otpController,
                      autoFocus: false,
                      useHapticFeedback: true,
                      enableActiveFill: true,
                      inputFormatters: const [],
                      useExternalAutoFillGroup: true,
                      backgroundColor: Colors.white,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      errorTextMargin: EdgeInsets.only(left: size(context).width * numD05),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size(context).width * numD045,
                      ),
                      onCompleted: (value) {
                        //onCompleteOtpFunc();
                      },
                      validator: (pin) {
                        if (pin.toString().isEmpty || pin!.length != 4) {
                          return "Please enter valid OTP";
                        }
                        return null;
                      },
                      onChanged: (pin) {
                        if (pin.length == 4) {
                          cubit.onComplete = true;
                        } else {
                          cubit.onComplete = false;
                        }
                      },
                      blinkWhenObscuring: true,
                      enablePinAutofill: true,
                      autoDismissKeyboard: false,
                      cursorHeight: size(context).width * numD07,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      length: 4,
                      separatorBuilder: (context,idx){
                        return Container(height: size(context).width * numD10,width: 1,color: Colors.grey.shade200,);
                      },
                      cursorColor: CommonColors.themeColor,
                      pinTheme: PinTheme(
                          inactiveColor: Colors.white,
                          activeColor: Colors.white,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(size(context).width * numD015),
                          selectedColor: Colors.white,
                          selectedFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          disabledColor: Colors.white,
                          fieldHeight: size(context).height * numD075,
                          fieldWidth: size(context).width * numD11,
                          activeFillColor: Colors.white,
                          fieldOuterPadding: EdgeInsets.only(right: size(context).width * numD05)),
                    ),
                  ),
                ),

                SizedBox(height: size(context).width * numD05),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    CommonText(
                        text: "Didn’t receive the code? ",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                    ),
                    InkWell(
                      onTap: (){
                        if (state.remainingTime == 0) {
                          cubit.startTimer();
                        }
                      },
                      child: CommonText(
                        text:  state.remainingTime > 0
                            ? formatTime(state.remainingTime)
                            : "Resend code",
                        fontSize: size(context).width * numD04,
                        color:Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),


                  ],
                ),


                SizedBox(height: size(context).width * numD1),

                CommonButton(
                  text: "Continue",
                  onTap: () {
                     //router.push(AppRouter.resetPasswordScreen);
                    router.go(AppRouter.homeScreen);

                    /*if (cubit.isFromSignIn) {
                      cubit.callVerifyPhoneOtpAPI();
                    } else if (cubit.isFromForgotPassword) {
                      cubit.callForgotPasswordOtpVerifyAPI();
                    } else {
                      cubit.callVerifyEmailPhoneOtpAPI();
                    }*/
                  },
                ),
                SizedBox(height: size(context).width * numD06),
              ],
            ),
          ),
        );
      },
    );
  }
}
