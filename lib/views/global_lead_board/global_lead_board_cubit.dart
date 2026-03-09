import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'global_lead_board_state.dart';

class GlobalLeadBoardCubit extends Cubit<GlobalLeadBoardState> {
  GlobalLeadBoardCubit() : super(GlobalLeadBoardInitial());
}
