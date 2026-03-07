import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import '../common_constants.dart';
import '../common_widgets/common_button/common_button.dart';
import '../common_widgets/common_text/common_text.dart';


class CommonAlertDialog {
  static Future<void> show({
    required BuildContext context,
    required String heading,
     String? subTitle,
     String? btnFirst,
     String? btnSecond,
     String? iconPath,
    required VoidCallback onFirstButtonTap,
    required VoidCallback onSecondButtonTap,
  })
  async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: size(context).width * numD40,
                horizontal: size(context).width * numD05,
              ),
              padding: EdgeInsets.all(size(context).width * numD03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size(context).width * numD06),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(iconPath !=null)
                  Image.asset(
                    iconPath,
                    width: size(context).width * numD12,
                    height: size(context).width * numD12,
                  ),
                  SizedBox(height: size(context).width * numD035),
                  CommonText(
                    text:heading,
                    fontSize: size(context).width * numD05,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,

                  ),
                  SizedBox(height: size(context).width * numD03),
                  CommonText(
                    text:subTitle,
                    textAlign: TextAlign.center,
                    fontSize: size(context).width * numD04,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,

                  ),
                  SizedBox(height: size(context).width * numD06),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                            text: btnFirst??"Continue",
                            onTap: () {
                              onFirstButtonTap();
                            },),
                      ),
                      SizedBox(width: size(context).width * numD04),
                      Expanded(
                        child: CommonGradientButton(
                            text: btnSecond??"Back",
                            onTap: () {
                              onSecondButtonTap();
                            },
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: size(context).width * numD02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
