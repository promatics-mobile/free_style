import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';

import '../../generated/assets.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../../utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'conversation_cubit.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "",
          titleWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                height: size(context).width * numD10,
                width: size(context).width * numD10,
                margin: EdgeInsets.all(size(context).width * numD01),
                child: ClipOval(
                  child: Image.asset(
                    Assets.assetsIcDummyUser2,
                    height: size(context).width * numD10,
                    width: size(context).width * numD10,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Rajan",

                      fontWeight: FontWeight.w500,
                      fontSize: size(context).width * numD04,
                    ),
                    /*CommonText(
                                    text: "@rajan2010",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size(context).width * numD035),*/
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: size(context).width * numD01,
                        ),
                        SizedBox(width: size(context).width * numD01),
                        CommonText(
                          text: "Online",

                          fontWeight: FontWeight.w500,
                          fontSize: size(context).width * numD03,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: "Block",
                  child: Row(
                    children: [
                      Icon(Icons.block, color: Colors.red),
                      SizedBox(width: size(context).width * numD02),
                      CommonText(
                        text: "Block",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: size(context).width * numD035,
                      ),
                    ],
                  ),
                ),
              ],
              icon: Container(
                padding: EdgeInsets.all(size(context).width * numD02),
                child: Icon(Icons.more_vert_sharp, color: CommonColors.secondaryColor),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ConversationCubit, ConversationState>(
          builder: (context, state) {
            var cubitData = context.read<ConversationCubit>();
            return aiChatWidget(context);
          },
        ),
      ),
    );
  }

  Widget aiChatWidget(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: size(context).width * numD02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      height: size(context).width * numD10,
                      width: size(context).width * numD10,
                      margin: EdgeInsets.all(size(context).width * numD02),
                      child: ClipOval(
                        child: Image.asset(
                          Assets.assetsIcDummyUser1,
                          height: size(context).width * numD10,
                          width: size(context).width * numD10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(size(context).width * numD02),
                        margin: EdgeInsets.only(right: size(context).width * numD02),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(size(context).width * numD04),
                            bottomRight: Radius.circular(size(context).width * numD04),
                            bottomLeft: Radius.circular(size(context).width * numD04),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: size(context).width * numD003,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CommonText(
                              text:
                                  "Hi Rajan, I've reviewed your recent activity in the app. Your progress looks good and your engagement has improved over the last few sessions. However, I noticed that your challenge attempts increased while your success rate slightly dropped.  Keep going — you're making steady progress!",
                              color: Colors.black,
                              fontSize: size(context).width * numD035,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CommonText(
                                  text: "10:30 AM",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size(context).width * numD03,
                                ),
                                SizedBox(width: size(context).width * numD01),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        SizedBox(
          height: size(context).width * numD20,
          width: size(context).width,
          child: Row(
            children: [
              SizedBox(width: size(context).width * numD02),
              Expanded(
                child: CommonTextFormField(
                  filled: true,
                  maxLines: 1,
                  maxLength: 4,
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size(context).width * numD03,
                    vertical: size(context).width * numD04,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(size(context).width * numD025)),
                  hint: "Type a Message..",
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Container(
                  decoration: commonBgColorDecoration(
                    size(context).width * numD08,
                    CommonColors.secondaryColor,
                  ),
                  padding: EdgeInsets.all(size(context).width * numD02),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
