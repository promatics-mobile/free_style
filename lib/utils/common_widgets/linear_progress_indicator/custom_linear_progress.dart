import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_constants.dart';

Widget commonLinearProgress({
  required BuildContext context,
  required double value,
  required Color bgColor,
  required Color valueColor,
}) {
  return Shimmer.fromColors(
    baseColor: bgColor,
    highlightColor: Colors.white.withValues(alpha: 0.7),
    direction: ShimmerDirection.ltr,
    period: const Duration(seconds: 6),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(size(context).width * numD02),
      child: LinearProgressIndicator(
        value: value,
        minHeight: size(context).width * numD02,
        backgroundColor: bgColor.withValues(alpha: 0.3),
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
      ),
    ),
  );
}

Widget commonNormalLinearProgress({
  required BuildContext context,
  required double value,
  required Color bgColor,
  required Color valueColor,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(size(context).width * numD02),
    child: LinearProgressIndicator(
      value: value,
      minHeight: size(context).width * numD02,
      backgroundColor: bgColor.withValues(alpha: 0.3),
      valueColor: AlwaysStoppedAnimation<Color>(valueColor),
    ),
  );
}
