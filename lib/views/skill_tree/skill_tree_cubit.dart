import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'skill_tree_state.dart';

class SkillTreeCubit extends Cubit<SkillTreeState> {
  SkillTreeCubit() : super(SkillTreeInitial());
}
