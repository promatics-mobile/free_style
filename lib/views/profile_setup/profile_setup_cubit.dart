import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit() : super(ProfileSetupInitial());
}
