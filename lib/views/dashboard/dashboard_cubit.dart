import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/views/social/social_screen.dart';
import '../battles/battles_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';


class DashboardCubit extends Cubit<DashboardState> {

  final List<Widget> dashboardScreens = [
    HomeScreen(),
    BattlesScreen(),
    SocialScreen(),
    ProfileScreen(),
  ];

  DashboardCubit(int value)
      : super(DashboardState(
          selectedIndex: 0,
          selectedTabIndex: 0,
          selectedTitle: "Home",
  )) {
    onTapBottomBar(value);
  }

  void onTapBottomBar(int index) {
    String name = "";

    switch(index){
      case 0:
        name = "Home";
        break;
      case 1:
        name = "Battles";
        break;
      case 2:
        name = "Social";
        break;
      case 3:
        name = "My profile";
        break;
    }
    state.selectedIndex = index;
    state.selectedTitle = name;
    emit(state.copyWith(
        selectedIndex: state.selectedIndex,
        selectedTitle : state.selectedTitle));
  }

  void onChangeHelpSupportTab(int index){
    emit(state.copyWith(selectedTabIndex: index));
  }

}

class DashboardState {
  int? selectedIndex;
  int? selectedTabIndex;
  String? selectedTitle;

  DashboardState({
    this.selectedIndex,
    this.selectedTitle,
    this.selectedTabIndex,
  });

  DashboardState copyWith({
    int? selectedIndex,
    int? selectedTabIndex,
    String? selectedTitle,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedTitle: selectedTitle ?? this.selectedTitle,
    );
  }
}
