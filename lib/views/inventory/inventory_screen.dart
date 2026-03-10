import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Inventory"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              height: size(context).width * numD09,
              width: size(context).width,
              child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  return Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD05,

                      idx == 0 ?
                      CommonColors.secondaryColor:
                      CommonColors.themeDarkColor
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD04,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD02,
                    ),
                    alignment: Alignment.center,
                    child: CommonText(
                      text:
                      idx == 0 ?
                      "Balls" : "Outfit",
                      color:
                      idx == 0 ?
                      Colors.black : Colors.white,
                      fontSize: size(context).width * numD035,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size(context).width * numD04),
            Expanded(
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: size(context).width * numD02,
                  mainAxisSpacing: size(context).width * numD02,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, idx) {
                  return InkWell(
                    onTap: (){
                      router.pop();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          size(context).width * numD03
                      ),
                      child: Container(
                        decoration: commonBgColorDecoration(
                          size(context).width * numD03,
                          CommonColors.themeDarkColor.withValues(alpha: 0.5),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CommonImage(
                                    imagePath:
                                    idx.isEven?
                                    Assets.iconsIcDummyBall1:
                                    Assets.iconsIsDummyBall2,
                                    width: size(context).width,
                                    isNetwork: false,
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size(context).width * numD04,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: CommonText(
                                    text: "Classic Sphere",
                                    fontSize: size(context).width * numD04,
                                  ),
                                ),

                                SizedBox(height: size(context).width * numD02),

                                if (idx == 0)
                                  Container(
                                    height: size(context).width * numD1,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size(context).width * numD04,
                                    ),
                                    alignment: Alignment.center,
                                    child: CommonGradientButton(
                                      onTap: () {
                                        router.pop();
                                      },
                                      text: "Equipped",
                                    ),
                                  ),

                                if (idx != 0)
                                Container(
                                    height: size(context).width * numD1,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size(context).width * numD04,
                                    ),
                                    alignment: Alignment.center,
                                    child: CommonGradientButton(onTap: () {
                                      router.pop();
                                    }, text: "Equip"),
                                  ),
                                SizedBox(height: size(context).width * numD02),
                              ],
                            ),
                            if (idx == 0)
                            Positioned(
                              top: size(context).width * numD02,
                              right: size(context).width * numD02,
                              child: Container(
                                decoration: commonBgColorDecoration(
                                  size(context).width * numD01,
                                  CommonColors.secondaryColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: size(context).width * numD02,
                                  vertical: size(context).width * numD005,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: size(context).width * numD04,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width:  size(context).width * numD01),
                                    CommonText(
                                      text: "Equipped",
                                      color: Colors.black,
                                      fontSize: size(context).width * numD03,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
