import 'dart:async';

class OtpVerificationState {
  Timer? timer;
  int remainingTime = 0;
  bool? btnLoader;
  bool agree;

  OtpVerificationState(
      {this.timer, required this.remainingTime, required this.agree, this.btnLoader});

  OtpVerificationState copyWith({
    Timer? timer,
    int? remainingTime,
    bool? isButtonEnabled,
    bool? btnLoader,
    bool? agree
  }) {
    return OtpVerificationState(
      timer: timer ?? this.timer,
      remainingTime: remainingTime ?? this.remainingTime,
      btnLoader:
      btnLoader ?? this.btnLoader,
        agree: agree ?? this.agree
    );
  }
}