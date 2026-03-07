import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import '../../common_constants.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? radius;

  const CommonButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size(context).width * numD15,
      width: size(context).width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? CommonColors.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? size(context).width * numD025),
          ),
        ),
        child: CommonText(
          text: text,
          color: textColor ?? Colors.white,
          fontSize: size(context).width * numD04,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}