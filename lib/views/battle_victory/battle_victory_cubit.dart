import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'battle_victory_state.dart';

class BattleVictoryCubit extends Cubit<BattleVictoryState> {
  BattleVictoryCubit() : super(BattleVictoryInitial());
}
