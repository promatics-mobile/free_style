import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/views/dashboard/dashboard_cubit.dart';
import 'package:free_style/views/settings/settings_cubit.dart';

import '../../routes/route.dart';
import '../../utils/common_alerts/common_alert_dialog.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        var cubitData = context.read<SettingsCubit>();
        return Scaffold(
          appBar: CommonAppBar(title: "Settings", showBack: true),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(size(context).width * numD04),
            child: Column(
              children: [

                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "Profile Setup",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.account_circle_outlined, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.profileSetupScreen);
                  },
                ),
                SizedBox(height: size(context).width * numD04),

                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "Verification",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.verified_outlined, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.emailMobileVerificationScreen);
                  },
                ),
                SizedBox(height: size(context).width * numD04),

                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "Change Password",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.lock_outline, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.changePasswordScreen);
                  },
                ),
                SizedBox(height: size(context).width * numD04),

                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "FAQs",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.question_answer_outlined, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.faqScreen);
                  },
                ),
                SizedBox(height: size(context).width * numD04),

                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "Contact Us",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.help_outline, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.contactUsScreen);
                  },
                ),
                SizedBox(height: size(context).width * numD04),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "About Us",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.info_outlined, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.cmsScreen, extra: "About Us");
                  },
                ),
                SizedBox(height: size(context).width * numD04),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "Terms & Conditions",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.description_outlined, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.cmsScreen, extra: "Terms & Conditions");
                  },
                ),
                SizedBox(height: size(context).width * numD04),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "Privacy Policy",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.privacy_tip_outlined, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    router.push(AppRouter.cmsScreen, extra: "Privacy Policy");
                  },
                ),
                SizedBox(height: size(context).width * numD04),

                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: CommonText(
                    text: "Logout",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                  ),
                  leading: Icon(Icons.logout_outlined, color: CommonColors.secondaryColor),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                  tileColor: CommonColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    CommonAlertDialog.show(
                      context: context,
                      heading: "Logout",
                      subTitle: "Are you sure you want to logout?",
                      onFirstButtonTap: () async{
                        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

                        if (Platform.isAndroid) {
                          AndroidDeviceInfo androidInfo =
                              await deviceInfo.androidInfo;
                          debugPrint('Running on ${androidInfo.id}');
                          cubitData.callRemoveDeviceApi(androidInfo.id);
                        } else if (Platform.isIOS) {
                          IosDeviceInfo iosInfo =
                              await deviceInfo.iosInfo;
                          debugPrint(
                              'Running on ${iosInfo.identifierForVendor}');
                          cubitData.callRemoveDeviceApi(
                            iosInfo.identifierForVendor ?? "",
                          );
                        }
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
                  title: CommonText(
                    text: "Delete Account",
                    fontSize: size(context).width * numD04,
                    fontWeight: .w500,
                    color: Colors.red,
                  ),
                  leading: Icon(Icons.delete_outline, color: Colors.red),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(size(context).width * numD02),
                  ),
                  onTap: () {
                    CommonAlertDialog.show(
                      context: context,
                      heading: "Delete Account",
                      subTitle: "Are you sure you want to delete your account?",
                      onFirstButtonTap: () async{
                        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

                        if (Platform.isAndroid) {
                          AndroidDeviceInfo androidInfo =
                          await deviceInfo.androidInfo;
                          debugPrint('Running on ${androidInfo.id}');
                          cubitData.callRemoveDeviceApi(androidInfo.id);
                        } else if (Platform.isIOS) {
                          IosDeviceInfo iosInfo =
                          await deviceInfo.iosInfo;
                          debugPrint(
                              'Running on ${iosInfo.identifierForVendor}');
                          cubitData.callRemoveDeviceApi(
                            iosInfo.identifierForVendor ?? "",
                          );
                        }

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
      },
    );
  }
}
