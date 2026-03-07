import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

class CommonGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CommonGradientButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size(context).width * numD15,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(context).width * numD03),
          gradient:  LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade700,
              Color(0xFF1F1C3A),
              CommonColors.themeColor
            ],
            stops: const [
              0.0,
              0.8,
              1.0,
            ],
          ),
          border: Border.all(
            color: CommonColors.buttonColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: CommonColors.buttonColor.withValues(alpha: 0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CommonText(
          text: text,
            fontSize: size(context).width * numD04,
            fontWeight: FontWeight.w600,
            color: Colors.white,

        ),
      ),
    );
  }
}