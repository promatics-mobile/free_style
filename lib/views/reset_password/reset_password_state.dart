class ResetPasswordState {
  bool agree;

  ResetPasswordState({required this.agree});


  ResetPasswordState copyWith({bool? agree}){
   return ResetPasswordState(agree: agree ?? this.agree);
  }

}