
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/views/tutorial/tutorial_vdo_details/tutorial_video_detail_state.dart';

class TutorialVdoDetailCubit extends Cubit<TutorialVdoDetailState>implements NetworkResponse {
  TutorialVdoDetailCubit() : super(TutorialVdoDetailState());

  @override
  void onApiError({required int requestCode, required String response}) {
    // TODO: implement onApiError
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    // TODO: implement onResponse
  }
}
