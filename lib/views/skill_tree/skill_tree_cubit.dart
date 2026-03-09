import 'package:bloc/bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:meta/meta.dart';
import 'package:universal_stepper/universal_stepper.dart';

part 'skill_tree_state.dart';

class SkillTreeCubit extends Cubit<SkillTreeState> {
  int currentStep = 2;
  int currentTabIndex = 0;

  StepperBadgePosition badgePosition =
      StepperBadgePosition.center; // Set the desired badgePosition

  bool isInverted = false;
  bool showGroundUnlock = false;

  List<StepperData> lowerStepData = [
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
  List<StepperData> upperStepData = [
    const StepperData(
      icon: Assets.iconsIcCheckNew,
      title: "Neck Stall",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcFilterHori,
      title: "Head Stall (Selected)",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcSteps,
      title: "Around the World (ATW)",
      subtitle: "",
    ),

  ];
  List<StepperData> groundStepData = [
    const StepperData(
      icon: Assets.iconsIcCheckNew,
      title: "Sole Roll",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcClock,
      title: "Mouse Trap",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcSteps,
      title: "Leg Circle (Selected)",
      subtitle: "",
    ),

  ];
  List<StepperData> sitDownStepData = [
    const StepperData(
      icon: Assets.iconsIcCheckNew,
      title: "Basic Sit",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcCheckNew,
      title: "Shin Stall (Rejected)",
      subtitle: "",
    ),
    const StepperData(
      icon: Assets.iconsIcSteps,
      title: "Knee Akka",
      subtitle: "",
    ),

  ];


  SkillTreeCubit() : super(SkillTreeInitial());


  void onChangeSkillTab(int index){
    currentTabIndex = index;
    emit(SkillTreeInitial());
  }

  void onTapGroundUnlock(){
    showGroundUnlock = !showGroundUnlock;
    emit(SkillTreeInitial());
  }




}
