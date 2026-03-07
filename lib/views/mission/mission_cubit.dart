import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mission_state.dart';

class MissionCubit extends Cubit<MissionState> {
  MissionCubit() : super(MissionInitial());
}
