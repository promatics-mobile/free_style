import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../common_constants.dart';
import '../common_decorations/common_decorations.dart';

class CommonShimmer extends StatelessWidget {
  final Widget child;

  const CommonShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.1),
      highlightColor: Colors.white.withValues(alpha: 0.2),
      child: child,
    );
  }
}

class VerticalListShimmer extends StatelessWidget {

  const VerticalListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.1),
      highlightColor: Colors.white.withValues(alpha: 0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size(context).width * numD20,
              height: size(context).width * numD06,
              decoration: commonBgColorDecoration(size(context).width * numD01, Colors.white),
            ),
            SizedBox(height: size(context).width * numD05),
            Column(
              children: List.generate(
                5, (index) =>  Container(
                  width: size(context).width ,
                  height: size(context).width * numD20,
                  padding: EdgeInsets.all(size(context).width * numD04),
                  margin: EdgeInsets.symmetric(
                    vertical: size(context).width * numD01,
                  ),
                  decoration: commonBgColorDecoration(size(context).width * numD02, Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HorizontalListShimmer extends StatelessWidget {
  final int itemCount;
  final double width;
  final double height;

  const HorizontalListShimmer({super.key, this.itemCount = 5, this.width = 120, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.1),
      highlightColor: Colors.white.withValues(alpha: 0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size(context).width * numD20,
              height: size(context).width * numD06,
              decoration: commonBgColorDecoration(size(context).width * numD01, Colors.white),
            ),
            SizedBox(height: size(context).width * numD05),
            Container(
              height: size(context).width * numD20,
              width: size(context).width,
              child: Row(
                children: List.generate(
                  5, (index) =>  Container(
                  width: size(context).width ,
                  height: size(context).width * numD20,
                  padding: EdgeInsets.all(size(context).width * numD04),
                  margin: EdgeInsets.symmetric(
                    vertical: size(context).width * numD01,
                  ),
                  decoration: commonBgColorDecoration(size(context).width * numD02, Colors.white),
                ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  final double radius;

  const ShimmerCircle({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: radius, backgroundColor: Colors.white);
  }
}
