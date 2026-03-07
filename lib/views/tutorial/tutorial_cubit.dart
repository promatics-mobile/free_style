import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tutorial_state.dart';

class TutorialCubit extends Cubit<TutorialState> {
  TutorialCubit() : super(TutorialInitial());
}
