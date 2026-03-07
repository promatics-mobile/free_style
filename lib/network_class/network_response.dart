import 'package:flutter/cupertino.dart';

class NetworkResponse {
  void onResponse({Key? key,required int requestCode,required String response}){}
  void onApiError({Key? key,required int requestCode,required String response}){}
}

