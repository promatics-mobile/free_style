import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'skill_state_state.dart';

class SkillStateCubit extends Cubit<SkillStateState> {
  SkillStateCubit() : super(SkillStateInitial());
}
