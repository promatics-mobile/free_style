import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit() : super(TrainingInitial());
  String goalType = "Free";


  void changeGoalType(String type) {
    goalType = type;
    emit(TrainingInitial());
  }
}
