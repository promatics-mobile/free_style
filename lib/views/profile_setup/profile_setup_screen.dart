import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:free_style/views/profile_setup/profile_setup_cubit.dart';

import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "",
      ),
      body: BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
        builder: (context, state) {
          var cubit = context.read<ProfileSetupCubit>();
          return SingleChildScrollView(
            padding: EdgeInsets.all(size(context).width * numD04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Setup Profile",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD07,
                ),

                CommonText(
                  text: "Customize your identity and preferences to get started",
                  fontSize: size(context).width * numD035,
                ),

                SizedBox(height: size(context).width * numD05),

                CommonTextFormField(
                  controller: cubit.usernameController,
                  filled: true,
                  enableShadow: true,
                  hint: "Enter Username",
                  keyboardType: TextInputType.text,
                  borderRadius: BorderRadius.circular(size(context).width * numD04),
                  prefixIcon: Container(
                    margin: EdgeInsets.only(left: size(context).width * numD04),
                    child: Icon(Icons.account_circle_outlined, color: CommonColors.buttonColor),
                  ),
                  suffixIcon:
                      (cubit.isUsernameAvailable &&
                          cubit.usernameController.text.length >= 6 &&
                          cubit.usernameController.text.isNotEmpty)
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onChanged: (value) {
                    cubit.checkUsernameAvailability(value);
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required*";
                    }
                    if (value.length < 6) {
                      return "Please enter username more than 6 characters";
                    }
                    if (!cubit.isUsernameAvailable) {
                      return "Username already taken";
                    }
                    return null;
                  },
                ),

                SizedBox(height: size(context).width * numD05),

                CommonText(
                  text: "Choose Avtar",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD04,
                ),
                SizedBox(height: size(context).width * numD04),
                GridView.builder(
                  itemCount: cubit.avatars.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: size(context).width * numD02,
                    mainAxisSpacing: size(context).width * numD02,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, idx) {
                    var item = cubit.avatars[idx];
                    return InkWell(
                      onTap: (){
                        cubit.onSelectAvatar(item.sId ?? "",item.picture!.first.fullPath!);
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipOval(
                            child: CommonImage(
                              imagePath: item.picture!.first.fullPath ?? "",
                              width: size(context).width * numD20,
                              height: size(context).width * numD20,
                              isNetwork: true,
                              border: BoxBorder.all(color:
                              item.sId == cubit.selectedAvatarId ?
                              CommonColors.secondaryColor : Colors.transparent),
                              shape: BoxShape.circle,
                            ),
                          ),
                          if(item.sId == cubit.selectedAvatarId)
                          Container(
                            decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.secondaryColor),
                            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD03),
                            child: CommonText(text:"Selected",color: CommonColors.themeColor,
                              fontSize: size(context).width * numD03,),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: size(context).width * numD05),

                CommonText(
                  text: "Ball Style",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD04,
                ),
                SizedBox(height: size(context).width * numD04),
                GridView.builder(
                  itemCount: cubit.balls.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: size(context).width * numD02,
                    mainAxisSpacing: size(context).width * numD02,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, idx) {
                    var item = cubit.balls[idx];
                    return InkWell(
                      onTap: (){
                        cubit.onSelectBall(item.sId ?? "",item.picture!.first.fullPath!);
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipOval(
                            child: CommonImage(
                              imagePath: item.picture!.first.fullPath ?? "",
                              width: size(context).width * numD20,
                              height: size(context).width * numD20,
                              isNetwork: true,
                              border: BoxBorder.all(color:
                              item.sId == cubit.selectedBallId ?
                              CommonColors.secondaryColor : Colors.transparent),
                              shape: BoxShape.circle,
                            ),
                          ),
                          if(item.sId == cubit.selectedBallId)
                            Container(
                              decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.secondaryColor),
                              padding: EdgeInsets.symmetric(horizontal: size(context).width * numD03),
                              child: CommonText(text:"Selected",color: CommonColors.themeColor,
                                fontSize: size(context).width * numD03,),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: size(context).width * numD1),

                CommonButton(
                  onTap: () {
                    if (cubit.usernameController.text.isEmpty) {
                      showToast(isError: true, message: "Please enter username to continue");
                    } else if (cubit.selectedAvatarId == null) {
                      showToast(isError: true, message: "Please select avatar to continue");
                    } else if (cubit.selectedBallId == null) {
                      showToast(isError: true, message: "Please select ball to continue");
                    } else {
                      cubit.callProfileSetupApi();
                    }
                  },
                  text: "Complete Setup",
                ),
                SizedBox(height: size(context).width * numD1),
              ],
            ),
          );
        },
      ),
    );
  }
}
