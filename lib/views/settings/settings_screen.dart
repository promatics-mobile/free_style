import 'package:flutter/material.dart';

import '../../routes/route.dart';
import '../../utils/common_alerts/common_alert_dialog.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Settings", showBack: true),
      body: Padding(
        padding: EdgeInsets.all(size(context).width * numD04),
        child: Column(
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "Profile Setup",fontSize: size(context).width * numD04,fontWeight: .w500,),
              leading: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
              ),
              tileColor: CommonColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {
                router.push(AppRouter.profileSetupScreen);
              },
            ),
            SizedBox(height: size(context).width * numD04),

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "FAQs",fontSize: size(context).width * numD04,fontWeight: .w500,),
              leading: Icon(
                Icons.question_answer_outlined,
                color: Colors.white,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
              ),
              tileColor: CommonColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {
                router.push(AppRouter.faqScreen);
              },
            ),
            SizedBox(height: size(context).width * numD04),

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "Contact Us",fontSize: size(context).width * numD04,fontWeight: .w500,),
              leading: Icon(Icons.help_outline, color: Colors.white),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
              ),
              tileColor: CommonColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {
                router.push(AppRouter.contactUsScreen);
              },
            ),
            SizedBox(height: size(context).width * numD04),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "About Us",fontSize: size(context).width * numD04,fontWeight: .w500,),
              leading: Icon(Icons.info_outlined, color: Colors.white),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
              ),
              tileColor: CommonColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {
                router.push(AppRouter.cmsScreen, extra: "About Us");
              },
            ),
            SizedBox(height: size(context).width * numD04),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "Terms & Conditions",fontSize: size(context).width * numD04,fontWeight: .w500,),
              leading: Icon(Icons.description_outlined, color: Colors.white),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
              ),
              tileColor: CommonColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {
                router.push(AppRouter.cmsScreen, extra: "Terms & Conditions");
              },
            ),
            SizedBox(height: size(context).width * numD04),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "Privacy Policy",fontSize: size(context).width * numD04,fontWeight: .w500,),
              leading: Icon(Icons.privacy_tip_outlined, color: Colors.white),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
              ),
              tileColor: CommonColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {
                router.push(AppRouter.cmsScreen, extra: "Privacy Policy");
              },
            ),
            SizedBox(height: size(context).width * numD04),

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "Logout",fontSize: size(context).width * numD04,fontWeight: .w500,),
              leading: Icon(Icons.logout_outlined, color: Colors.white),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
              ),
              tileColor: CommonColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {
                CommonAlertDialog.show(
                  context: context,
                  heading: "Logout",
                  subTitle: "Are you sure you want to logout?",
                  onFirstButtonTap: () {

                    router.go(AppRouter.walkThroughScreen);

                  },
                  onSecondButtonTap: () {
                    router.pop();
                  },
                );
              },
            ),
            SizedBox(height: size(context).width * numD04),

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: CommonText(text: "Delete Account",fontSize: size(context).width * numD04,fontWeight: .w500, color: Colors.red),
              leading: Icon(Icons.delete_outline, color: Colors.red),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.red,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  size(context).width * numD02,
                ),
              ),
              onTap: () {

                CommonAlertDialog.show(
                  context: context,
                  heading: "Delete Account",
                  subTitle: "Are you sure you want to delete your account?",
                  onFirstButtonTap: () {
                    router.go(AppRouter.walkThroughScreen);
                  },
                  onSecondButtonTap: () {
                    router.pop();
                  },
                );

              },
            ),
            SizedBox(height: size(context).width * numD19),
          ],
        ),
      ),
    );
  }
}
