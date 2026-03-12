import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: CommonColors.secondaryColor,),
    );
  }
}