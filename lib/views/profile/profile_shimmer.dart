import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.1),
      highlightColor: Colors.white.withValues(alpha: 0.2),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size(context).width * numD04),
              // Profile Image Placeholder
              CircleAvatar(radius: size(context).width * numD12, backgroundColor: Colors.white),
              SizedBox(height: size(context).width * numD04),
              // Name Placeholder
              Container(
                width: size(context).width * numD40,
                height: size(context).width * numD05,
                decoration: commonBgColorDecoration(size(context).width * numD01, Colors.white),
              ),
              SizedBox(height: size(context).width * numD02),
              // Level Placeholder
              Container(
                width: size(context).width * numD30,
                height: size(context).width * numD03,
                decoration: commonBgColorDecoration(size(context).width * numD01, Colors.white),
              ),
              SizedBox(height: size(context).width * numD04),
              // Inventory Button Placeholder
              Container(
                width: size(context).width * numD25,
                height: size(context).width * numD08,
                decoration: commonBgColorDecoration(size(context).width * numD04, Colors.white),
              ),
              SizedBox(height: size(context).width * numD06),
              // Stats Placeholders
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      Container(
                        width: size(context).width * numD1,
                        height: size(context).width * numD05,
                        decoration: commonBgColorDecoration(
                          size(context).width * numD01,
                          Colors.white,
                        ),
                      ),
                      SizedBox(height: size(context).width * numD01),
                      Container(
                        width: size(context).width * numD15,
                        height: size(context).width * numD03,
                        decoration: commonBgColorDecoration(
                          size(context).width * numD01,
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size(context).width * numD06),
              // Level Progress Card Placeholder
              Container(
                width: double.infinity,
                height: size(context).width * numD30,
                decoration: commonBgColorDecoration(size(context).width * numD04, Colors.white),
              ),
              SizedBox(height: size(context).width * numD06),
              // Tab Bar Placeholder
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: size(context).width * numD20,
                    height: size(context).width * numD08,
                    decoration: commonBgColorDecoration(size(context).width * numD01, Colors.white),
                  ),
                ),
              ),
              SizedBox(height: size(context).width * numD04),
              // List Items Placeholder
              Column(
                children: List.generate(
                  5,
                  (index) => Container(
                    width: double.infinity,
                    height: size(context).width * numD15,
                    margin: EdgeInsets.only(bottom: size(context).width * numD02),
                    decoration: commonBgColorDecoration(size(context).width * numD04, Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
