import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'challenge_history_state.dart';

class ChallengeHistoryCubit extends Cubit<ChallengeHistoryState> {
  ChallengeHistoryCubit() : super(ChallengeHistoryInitial());
}
