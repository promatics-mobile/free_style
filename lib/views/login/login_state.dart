class LogInState {
  bool agree;

  LogInState({required this.agree});


  LogInState copyWith({bool? agree}){
   return LogInState(agree: agree ?? this.agree);
  }

}