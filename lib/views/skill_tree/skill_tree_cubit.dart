import 'package:bloc/bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:meta/meta.dart';
import 'package:universal_stepper/universal_stepper.dart';

part 'skill_tree_state.dart';

class SkillTreeCubit extends Cubit<SkillTreeState> {
  int currentStep = 2;

  StepperBadgePosition badgePosition =
      StepperBadgePosition.center; // Set the desired badgePosition

  bool isInverted = false;

  List<StepperData> stepperData = [
    const StepperData(
      icon: Assets.iconsIcCheckNew,
      title: "Basic Touch Control",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcCheckNew,
      title: "Crossover Control",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcSteps,
      title: "Around the World (ATW)",
      subtitle: "",
    ),

  ];


  SkillTreeCubit() : super(SkillTreeInitial());



}
