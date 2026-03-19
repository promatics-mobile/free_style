import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../utils/common_methods.dart';

part 'submit_proof_state.dart';

class SubmitProofCubit extends Cubit<SubmitProofState> {
  String id = "";
  SubmitProofCubit({required this.id}) : super(SubmitProofInitial());
  String previewVideoPath = "";
  String previewVideoThumbnailPath = "";


  void onAddVideoForPreview(String filePath){
    previewVideoPath = filePath;
    debugPrint("previewVideoPath::$previewVideoPath");

    generateThumbnailFile(filePath).then((thumb){
      debugPrint("thumb::$thumb");
      if(thumb !=null){
        previewVideoThumbnailPath = thumb.path;
      }
    });
    emit(SubmitProofInitial());
  }

}
