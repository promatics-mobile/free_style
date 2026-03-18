import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:universal_stepper/universal_stepper.dart';

import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';

part 'skill_tree_state.dart';

class SkillTreeCubit extends Cubit<SkillTreeState> implements NetworkResponse {
  int currentStep = 2;
  int currentTabIndex = 0;

  StepperBadgePosition badgePosition = StepperBadgePosition.center; // Set the desired badgePosition

  bool isInverted = false;
  bool showGroundUnlock = false;

  List<StepperData> lowerStepData = [
    const StepperData(icon: Assets.iconsIcCheckNew, title: "Basic Touch Control", subtitle: ""),
    const StepperData(icon: Assets.iconsIcCheckNew, title: "Crossover Control", subtitle: ""),
    const StepperData(icon: Assets.iconsIcSteps, title: "Around the World (ATW)", subtitle: ""),
  ];
  List<StepperData> upperStepData = [
    const StepperData(icon: Assets.iconsIcCheckNew, title: "Neck Stall", subtitle: ""),
    const StepperData(icon: Assets.iconsIcFilterHori, title: "Head Stall (Selected)", subtitle: ""),
    const StepperData(icon: Assets.iconsIcSteps, title: "Around the World (ATW)", subtitle: ""),
  ];
  List<StepperData> groundStepData = [
    const StepperData(icon: Assets.iconsIcCheckNew, title: "Sole Roll", subtitle: ""),
    const StepperData(icon: Assets.iconsIcClock, title: "Mouse Trap", subtitle: ""),
    const StepperData(icon: Assets.iconsIcSteps, title: "Leg Circle (Selected)", subtitle: ""),
  ];
  List<StepperData> sitDownStepData = [
    const StepperData(icon: Assets.iconsIcCheckNew, title: "Basic Sit", subtitle: ""),
    const StepperData(icon: Assets.iconsIcCheckNew, title: "Shin Stall (Rejected)", subtitle: ""),
    const StepperData(icon: Assets.iconsIcSteps, title: "Knee Akka", subtitle: ""),
  ];

  SkillTreeCubit() : super(SkillTreeState(branchList: [], tierList: [], skillList: [])) {
    callBranchesApi();
    callGetTiersApi();
  }

  void onChangeTierTab(int index) {
    emit(state.copyWith(selectedTierIndex: index));
    callGetSkillsApi();
  }

  void onChangeSkillTab(int index) {
    currentTabIndex = index;
    callGetSkillsApi();
  }

  void onTapGroundUnlock() {
    showGroundUnlock = !showGroundUnlock;
    emit(state.copyWith());
  }

  void callBranchesApi() {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: getBranchesUrl,
      requestCode: getBranchesReq,
      showLoader: true,
      json: {},
    );
  }

  void callGetTiersApi() {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: getTiersUrl,
      requestCode: getTiersReq,
      json: {},
    );
  }

  void callGetSkillsApi() {
    if (state.branchList.isEmpty || state.tierList.isEmpty) return;

    final branchId = state.branchList[currentTabIndex].id;
    final tierId = state.tierList[state.selectedTierIndex].id;




    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: getSkillsUrl,
      requestCode: getSkillsReq,
      query: {'offset': '', 'limit': '', 'branchId': branchId, 'tierId': tierId},
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    emit(state.copyWith());
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case getBranchesReq:
        var map = jsonDecode(response);
        if (map["success"] == true) {
          final List<BranchModel> branches = (map["branches"] as List? ?? [])
              .map((e) => BranchModel.fromJson(e))
              .toList();

          emit(state.copyWith(branchList: branches));
          callGetSkillsApi();
        }
        break;

      case getTiersReq:
        var map = jsonDecode(response);
        if (map["success"] == true) {
          final List<TierModel> tiers = (map["tiers"] as List? ?? [])
              .map((e) => TierModel.fromJson(e))
              .toList();

          emit(state.copyWith(tierList: tiers));
          callGetSkillsApi();
        }
        break;

      case getSkillsReq:
        var map = jsonDecode(response);
        if (map["success"] == true) {
          final List<SkillModel> skills = (map["skills"] as List? ?? [])
              .map((e) => SkillModel.fromJson(e))
              .toList();

          emit(state.copyWith(skillList: skills));
        }
        break;
    }
  }
}
