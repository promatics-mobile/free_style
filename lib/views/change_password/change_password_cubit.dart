import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState>{

  bool currentPass = false;
  bool newPass = true;
  bool confirmPass = true;
  var currentController = TextEditingController();
  var newController = TextEditingController();
  var confirmController = TextEditingController();

  ChangePasswordCubit() : super(ChangePasswordState());


  currentPassFn(){
    currentPass = !currentPass;
    emit(state.copyWith());
  }
  newPassFn(){
    newPass = !newPass;
    emit(state.copyWith());
  }
  confirmPassFn(){
    confirmPass = !confirmPass;
    emit(state.copyWith());
  }

  onSubmitFn(){
    currentController.clear();
    newController.clear();
    confirmController.clear();
    emit(state.copyWith());
  }
}

class ChangePasswordState {
  String? title;

  ChangePasswordState({this.title});

  ChangePasswordState copyWith({
    String? title,
}){
    return ChangePasswordState(
      title: title ?? this.title
    );
  }
}