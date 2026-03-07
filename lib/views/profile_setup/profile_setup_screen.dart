import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';

import '../../generated/assets.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "",actions: [
        commonTextButton(onTap: (){}, size: size(context),
            buttonText: "Skip")
      ],),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(size(context).width * numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CommonText(text: "Setup Profile",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD07,),

            CommonText(text: "Customize your identity and preferences to get started",
              fontSize: size(context).width * numD035,),

            SizedBox(height: size(context).width * numD05,),

            CommonTextFormField(
              filled: true,
              enableShadow: true,
              hint: "Enter Username",
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(size(context).width * numD04),
              prefixIcon: Container(
                  margin:EdgeInsets.only(left: size(context).width * numD04),
                  child: Icon(Icons.account_circle_outlined,color: CommonColors.buttonColor,)),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Required*";
                }
                return null;
              },
            ),

            SizedBox(height: size(context).width * numD05),

            CommonText(text: "Choose Avtar",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD04,),
            GridView.builder(
              itemCount: 8,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                  crossAxisSpacing: size(context).width * numD02,
                  mainAxisSpacing: size(context).width * numD02,
                  childAspectRatio: 1.1),
              itemBuilder: (context,idx){

                return ClipOval(
                  child: CommonImage(imagePath: Assets.assetsIcDummyUser2,
                    width: size(context).width * numD20,
                    height: size(context).width * numD20,
                    isNetwork: false,),
                );
              }, ),

            SizedBox(height: size(context).width * numD05),

            CommonText(text: "Ball Style",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD04,),
            GridView.builder(
              itemCount: 8,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                  crossAxisSpacing: size(context).width * numD02,
                  mainAxisSpacing: size(context).width * numD02,
                  childAspectRatio: 1.1),
              itemBuilder: (context,idx){

                return ClipOval(
                  child: CommonImage(imagePath: Assets.iconsIcFootballWhite,
                    width: size(context).width * numD20,
                    height: size(context).width * numD20,
                    isNetwork: false,),
                );
              }, ),
            SizedBox(height: size(context).width * numD1,),
            
            CommonButton(onTap: (){}, text: "Complete Setup"),
            SizedBox(height: size(context).width * numD1,),
          ],
        ),
      ),
    );
  }
}
