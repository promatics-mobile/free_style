import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class SearchPlayersScreen extends StatelessWidget {
  const SearchPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Search Players", showBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextFormField(
              filled: true,
              enableShadow: true,
              hint: "Search Player",
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(size(context).width * numD04),
              prefixIcon: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD03,
                ),
                child: Icon(Icons.search, color: CommonColors.buttonColor),
              ),
              suffixIcon: Icon(Icons.cancel_outlined, color: Colors.black),
            ),
            SizedBox(height: size(context).width * numD02),
            CommonText(
              text: "Search Results",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,
            ),
            SizedBox(height: size(context).width * numD02),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
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

                          if (idx == 2)
                            commonOutlinedButton(
                              onTap: () {},
                              size: size(context),
                              borderColor: CommonColors.buttonColor,
                              buttonHeight: size(context).width * numD10,
                              buttonText: CommonText(
                                text: "Requested",
                                color: CommonColors.buttonColor,
                              ),
                            )
                          else
                            commonShortButton(
                              onTap: () {},
                              size: size(context),
                              buttonHeight: size(context).width * numD10,
                              buttonText: "Add",
                            ),
                        ],
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
