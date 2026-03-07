import 'package:bloc/bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

 List<MenuItemModel> menuItemsList = [
    MenuItemModel(title: "Battle Arena", icon:Assets.iconsIcBattle),
    MenuItemModel(title: "Training", icon:Assets.iconsIcOutlineFootball),
    MenuItemModel(title: "Skill Tree",icon:Assets.iconsIcSkillTree),
    MenuItemModel(title: "Skill States",icon:Assets.iconsIcSkillState),
    MenuItemModel(title: "Tutorials",icon:Assets.iconsIcVideoRecord),
    MenuItemModel(title: "Missions",icon:Assets.iconsIcOutlineFootball),
  ];
}
