import 'package:flutter/material.dart';

import '../../common_constants.dart';
import '../common_text/common_text.dart';

Widget commonShortButtonWithIcon({
  required Function() onTap,
  required Size size,
  required String buttonText,
  required Widget iconWidget,
  Color? buttonColor,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  double? buttonHeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD05,
    child: ElevatedButton.icon(
      icon: iconWidget,
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? size.width * numD01),
        ),
        backgroundColor: buttonColor ?? CommonColors.themeColor,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      label: Text(
        buttonText,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget commonShortButton({
  required Function() onTap,
  required Size size,
  required String buttonText,
  Color? buttonColor,
  Color? textColor,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  double? buttonHeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD05,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? size.width * numD01),
        ),
        backgroundColor: buttonColor ?? CommonColors.buttonColor,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget commonShortButtonWidth({
  required Function() onTap,
  required Size size,
  required String buttonText,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  double? buttonHeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD05,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? size.width * numD01),
        ),
        backgroundColor: CommonColors.themeColor,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget commonShortOutlinedButton({
  required Function() onTap,
  required Size size,
  required String buttonText,
  Color? buttonColor,
  double? radius,
  double? fontSize,
  double? buttonHeight,
  FontWeight? fontWeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD14,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: buttonColor ?? CommonColors.themeColor),
          borderRadius: BorderRadius.circular(radius ?? (size.width * numD01)),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonColor ?? CommonColors.themeColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}


Widget commonTextButton({
  required Function() onTap,
  required Size size,
  required String buttonText,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextButton(
    onPressed: () {
      onTap();
    },
    child: CommonText(
      text: buttonText,
      fontSize: fontSize ?? size.width * numD035,
      fontWeight: fontWeight ?? FontWeight.w500,
      textAlign: TextAlign.center,
      color: color ?? Colors.white,
    ),
  );
}

Widget commonOutlinedButton({
  required Function() onTap,
  required Size size,
  required Widget buttonText,
  double? radius,
  double? buttonHeight,
  double? horizontalPadding,
  Color? borderColor,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD14,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? CommonColors.themeColor),
          borderRadius: BorderRadius.circular(size.width * (radius ?? numD02)),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: buttonText,
    ),
  );
}
