class CreateAccountState{
  int i;

  CreateAccountState({this.i = 0});
  CreateAccountState copyWith({
    int? i,
  }) {
    return CreateAccountState(
      i: i ?? this.i
    );
  }

}