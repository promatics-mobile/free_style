import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../skill_tree/skill_tree_cubit.dart';

part 'daily_challenge_state.dart';

class DailyChallengeCubit extends Cubit<DailyChallengeState> {
  DailyChallengeCubit() : super(DailyChallengeInitial());
  List<StepperData> stepData = [
    const StepperData(
      icon:"",
      title: "Around the World",
      subtitle: "Basics • Lower",
    ),
    const StepperData(
      icon:"",
      title: "Crossover",
      subtitle: "Basics • Lower",
    ),
    const StepperData(
      icon:"",
      title: "Toe Bounce",
      subtitle: "Intermediate • Ground",
    ),

  ];

}
