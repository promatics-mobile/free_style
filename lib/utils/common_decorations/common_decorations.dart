import 'dart:ui' show Size;

import 'package:flutter/material.dart';

import '../common_constants.dart';

BoxDecoration commonDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonDecorationTopOnly(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonWhiteDecorationTopOnly(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonTabDecorationTopOnly(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.themeColor.withOpacity(0.1),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonWhiteDecoration(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border(
      left: BorderSide(
        width: size.width * numD01,
        color: CommonColors.secondaryColor,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: size.width * numD003,
        //spreadRadius: size.width * numD003,
      ),
    ],
  );
}

BoxDecoration commonOutlineDecoration(double radius, double borderWidth, Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    border: Border.all(width: borderWidth, color: color),
  );
}

BoxDecoration commonLightWhiteDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.secondaryLightColor,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border(
      left: BorderSide(
        width: size.width * numD01,
        color: CommonColors.secondaryColor,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: size.width * numD003,
        //spreadRadius: size.width * numD003,
      ),
    ],
  );
}

BoxDecoration commonSelectedBottomDecoration(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgLightWhiteDecoration(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white.withValues(alpha: 0.3),
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgGreyDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor.withValues(alpha: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgLightGreyDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor.withValues(alpha: 0.1),
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgLightGreyTopOnlyDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor.withValues(alpha: 0.1),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonBgColorTopOnlyDecoration(
  Size size,
  Color color,
  double radius,
) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonBgColorDecoration(double radius, Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

BoxDecoration commonCircularBorder({
  Color borderColor = Colors.grey,
  double borderWidth = 1.5,
  Color backgroundColor = Colors.transparent,
  List<BoxShadow>? boxShadow,
}) {
  return BoxDecoration(
    shape: BoxShape.circle,
    color: backgroundColor,
    border: Border.all(color: borderColor, width: borderWidth),
    boxShadow: boxShadow,
  );
}

/// Circular filled background (no border)
BoxDecoration commonCircularFill({required Color color, List<BoxShadow>? boxShadow}) {
  return BoxDecoration(
    shape: BoxShape.circle,
    color: color,
    boxShadow: boxShadow,
  );
}
