import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../common_constants.dart';

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
  final int itemCount;
  final double height;

  const VerticalListShimmer({
    super.key,
    this.itemCount = 5,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
            (index) => CommonShimmer(
              child: Container(height: size(context).width * numD08,width: size(context).width,),
            ),
      ),
    );
  }
}

class HorizontalListShimmer extends StatelessWidget {
  final int itemCount;
  final double width;
  final double height;

  const HorizontalListShimmer({
    super.key,
    this.itemCount = 5,
    this.width = 120,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) =>  SizedBox(width: 12),
        itemBuilder: (_, __) => CommonShimmer(
          child: ShimmerCircle(radius: size(context).width * numD1),
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
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
    );
  }
}


