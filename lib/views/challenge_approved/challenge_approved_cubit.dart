import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'challenge_approved_state.dart';

class ChallengeApprovedCubit extends Cubit<ChallengeApprovedState> {
  ChallengeApprovedCubit() : super(ChallengeApprovedInitial());
}
