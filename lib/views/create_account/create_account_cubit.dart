import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_cubit.dart';
import 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  bool isObscure = false;
  bool keepSigned = false;
  bool isAgeSelected = false;
  bool isTermsSelected = false;

  CreateAccountCubit() : super(CreateAccountState());


  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  LoginType loginType = LoginType.email;

  String countryCode = '+91';
  int phoneMaxLength = 10;

  void updateCountryCode(String code) {
    countryCode = code.startsWith('+') ? code : '+$code';
    debugPrint("Code:::::: $countryCode");

    switch (countryCode) {
      case '+91':
        phoneMaxLength = 10;
        break;

      case '+1':
        phoneMaxLength = 10;
        break;

      case '+44':
        phoneMaxLength = 10;
        break;

      case '+971':
        phoneMaxLength = 9;
        break;

      case '+49':
        phoneMaxLength = 11;
        break;

      default:
        phoneMaxLength = 12;
    }
    emit(state.copyWith());
  }

  void changeType(LoginType type) {
    clear();
    loginType = type;
    emit(state.copyWith());
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  void isObscureFn() {
    isObscure = !isObscure;
    emit(state.copyWith());
  }

  void onAgeSelected() {
    isAgeSelected = !isAgeSelected;
    emit(state.copyWith());
  }
  void onAgreeTerms() {
    isTermsSelected = !isTermsSelected;
    emit(state.copyWith());
  }




}
