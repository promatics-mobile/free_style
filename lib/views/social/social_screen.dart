import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: "Incoming Challenges (1)",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,
            ),
            SizedBox(height: size(context).width * numD02),
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: size(context).width * numD02),
              itemBuilder: (context, idx) {
                return InkWell(
                  onTap: () {
                    router.push(AppRouter.otherProfileScreen);
                  },
                  child: Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD04,
                      Colors.white,
                    ),
                    padding: EdgeInsets.all(size(context).width * numD04),
                    margin: EdgeInsets.symmetric(
                      vertical: size(context).width * numD01,
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: CommonImage(
                                imagePath: Assets.assetsIcDummyUser2,
                                width: size(context).width * numD1,
                                height: size(context).width * numD1,
                                isNetwork: false,
                              ),
                            ),
                            SizedBox(width: size(context).width * numD02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: "@Kim_skater",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size(context).width * numD04,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size(context).width * numD02,
                                  ),
                                  child: CommonText(
                                    text: "Blue Tier 1 ${CommonSymbol.dotSymbol} Wants to battle!",
                                    color: Colors.black,
                                    fontSize: size(context).width * numD03,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size(context).width * numD02),
                        Row(
                          children: [
                            Expanded(
                              child: commonOutlinedButton(onTap: (){},
                                  size: size(context),
                                  radius: numD03,
                                  borderColor: Colors.red,
                                  buttonHeight:size(context).width * numD1,
                                  buttonText: CommonText(text:"Cancel",color: Colors.red,)),
                            ),

                            SizedBox(width:  size(context).width * numD02),

                            Expanded(
                              child: commonShortButton(onTap: (){

                                router.push(AppRouter.matchMakingScreen);
                              },
                                  size: size(context),
                                  radius: size(context).width * numD03,
                                  buttonHeight:size(context).width * numD1,
                                  buttonText: "Accept Battle"),
                            )
                          ],
                        )


                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: size(context).width * numD04),

            CommonText(
              text: "Pending Requests (2)",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,
            ),
            SizedBox(height: size(context).width * numD02),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: size(context).width * numD02),
              itemBuilder: (context, idx) {
                return InkWell(
                  onTap: () {
                    router.push(AppRouter.otherProfileScreen);
                  },
                  child: Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD04,
                      Colors.white,
                    ),
                    padding: EdgeInsets.all(size(context).width * numD04),
                    margin: EdgeInsets.symmetric(
                      vertical: size(context).width * numD01,
                    ),

                    child: Row(
                      children: [
                        ClipOval(
                          child: CommonImage(
                            imagePath: Assets.assetsIcDummyUser2,
                            width: size(context).width * numD1,
                            height: size(context).width * numD1,
                            isNetwork: false,
                          ),
                        ),
                        SizedBox(width: size(context).width * numD02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: "@NeonNinja",
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size(context).width * numD04,
                            ),
                            Container(
                              decoration: commonBgColorDecoration(
                                size(context).width * numD04,
                                CommonColors.secondaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size(context).width * numD02,
                              ),
                              child: CommonText(
                                text: "SILVER 1",
                                color: Colors.black,
                                fontSize: size(context).width * numD03,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        commonShortButton(
                          onTap: () {},
                          size: size(context),
                          radius: size(context).width * numD03,
                          buttonHeight: size(context).width * numD10,
                          buttonText: "Accept",
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: commonOutlineDecoration(
                              size(context).width * numD02,
                              1,
                              CommonColors.buttonColor,
                            ),
                            padding: EdgeInsets.all(
                              size(context).width * numD015,
                            ),
                            child: Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: size(context).width * numD04),
            CommonText(
              text: "My Friends (5)",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,
            ),
            SizedBox(height: size(context).width * numD02),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: size(context).width * numD02),
              itemBuilder: (context, idx) {
                return InkWell(
                  onTap: () {
                    router.push(AppRouter.otherProfileScreen);
                  },
                  child: Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD04,
                      Colors.white,
                    ),
                    padding: EdgeInsets.all(size(context).width * numD04),
                    margin: EdgeInsets.symmetric(
                      vertical: size(context).width * numD01,
                    ),

                    child: Row(
                      children: [
                        ClipOval(
                          child: CommonImage(
                            imagePath: Assets.assetsIcDummyUser2,
                            width: size(context).width * numD1,
                            height: size(context).width * numD1,
                            isNetwork: false,
                          ),
                        ),
                        SizedBox(width: size(context).width * numD02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: "@QueenBee",
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size(context).width * numD04,
                            ),
                            Container(
                              decoration: commonBgColorDecoration(
                                size(context).width * numD04,
                                CommonColors.secondaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size(context).width * numD02,
                              ),
                              child: CommonText(
                                text: "GOLD 1",
                                color: Colors.black,
                                fontSize: size(context).width * numD03,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),

                        commonShortButton(
                          onTap: () {},
                          size: size(context),
                          radius: size(context).width * numD03,
                          buttonHeight: size(context).width * numD10,
                          buttonText: "Invite",
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: commonOutlineDecoration(
                              size(context).width * numD02,
                              1,
                              Colors.red,
                            ),
                            padding: EdgeInsets.all(
                              size(context).width * numD015,
                            ),
                            child: Icon(
                              Icons.person_remove_alt_1_rounded,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
