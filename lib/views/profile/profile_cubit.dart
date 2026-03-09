import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  int selectedTabIndex = 0;

  void onChangeTab(int index){
    selectedTabIndex = index;
    emit(ProfileInitial());
  }

}
