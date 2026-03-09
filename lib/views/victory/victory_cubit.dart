import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'victory_state.dart';

class VictoryCubit extends Cubit<VictoryState> {
  VictoryCubit() : super(VictoryInitial());
}
