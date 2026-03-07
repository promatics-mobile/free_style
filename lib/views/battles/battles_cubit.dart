import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'battles_state.dart';

class BattlesCubit extends Cubit<BattlesState> {
  BattlesCubit() : super(BattlesInitial());
}
