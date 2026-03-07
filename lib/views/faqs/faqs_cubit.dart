import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'faqs_state.dart';

class FaqsCubit extends Cubit<FaqsState> {
  FaqsCubit() : super(FaqsInitial());
}
