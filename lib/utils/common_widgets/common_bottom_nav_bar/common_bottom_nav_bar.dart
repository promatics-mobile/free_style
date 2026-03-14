import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import '../../../generated/assets.dart';
import '../../common_constants.dart';

class GameBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GameBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const double navHeight = 65.0; // Height of the white bar
    const double topMargin = 25.0; // Space for the curve bump
    final double itemWidth = width / 4;

    return Container(
      height: navHeight + topMargin,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Background Shape (White bar with U-bump)
          Container(
            color: Colors.transparent,
            child: CustomPaint(
              size: Size(width, navHeight + topMargin),
              painter: _BottomNavPainter(
                currentIndex: currentIndex,
                itemWidth: itemWidth,
                topMargin: topMargin,
              ),
            ),
          ),

          // 2. Selection Indicator (Yellow Circle)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutQuart,
            left: (currentIndex * itemWidth) + (itemWidth / 2) - 25,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: CommonColors.secondaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: CommonColors.secondaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),

          // 3. Navigation Items (Icons and Labels)
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  _buildItem(context, 0, Assets.iconsIcHome, "Home", itemWidth),
                  _buildItem(context, 1, Assets.iconsIcBattle, "Battle", itemWidth),
                  _buildItem(context, 2, Assets.iconsIcSocial, "Social", itemWidth),
                  _buildItem(context, 3, Assets.iconsIcProfile, "Profile", itemWidth),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, String icon, String label, double itemWidth) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: itemWidth,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: isSelected ? MainAxisAlignment.start:MainAxisAlignment.center,
          children: [
            // Container for the icon - height matches the circle to aid centering
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutQuart,
              height: 50,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: isSelected ? 1 : 20, // Lift the icon into the circle or keep it in the bar
              ),
              child: Image.asset(
                icon,
                height: 20,
                width: 20,
                color: Colors.black,
              ),
            ),
            if(isSelected)
              CommonText(
                text:label,
                color: Colors.black,
                fontSize: size(context).width * numD03,
                fontWeight: FontWeight.bold ,

              ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavPainter extends CustomPainter {
  final int currentIndex;
  final double itemWidth;
  final double topMargin;

  _BottomNavPainter({
    required this.currentIndex,
    required this.itemWidth,
    required this.topMargin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();

    double centerX = (currentIndex * itemWidth) + (itemWidth / 2);
    double curveWidth = 55;
    double curveHeight = 28;

    path.moveTo(0, topMargin);

    // Left part
    path.lineTo(centerX - curveWidth, topMargin);

    // Smooth U-Curve Peak
    path.cubicTo(
      centerX - (curveWidth * 0.5),
      topMargin,
      centerX - (curveWidth * 0.5),
      topMargin - curveHeight,
      centerX,
      topMargin - curveHeight,
    );

    // Smooth U-Curve Exit
    path.cubicTo(
      centerX + (curveWidth * 0.5),
      topMargin - curveHeight,
      centerX + (curveWidth * 0.5),
      topMargin,
      centerX + curveWidth,
      topMargin,
    );

    path.lineTo(size.width, topMargin);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.transparent, 10, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BottomNavPainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex;
  }
}




