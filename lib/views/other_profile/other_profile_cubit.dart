import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'other_profile_state.dart';

class OtherProfileCubit extends Cubit<OtherProfileState> {
  OtherProfileCubit() : super(OtherProfileInitial());
}
