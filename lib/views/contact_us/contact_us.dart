import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';

import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'contact_us_cubit.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Contact Us"),
      body: BlocBuilder<ContactUsCubit, ContactUsState>(
  builder: (context, state) {
    var cubit = context.read<ContactUsCubit>();
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size(context).width * numD04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD03,
                  Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD02,
                  vertical: size(context).width * numD04,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: size(context).width * numD05,
                      backgroundColor: CommonColors.secondaryLightColor,
                      child: Icon(Icons.add_ic_call_sharp, color: Colors.black),
                    ),

                    SizedBox(width: size(context).width * numD02),

                    CommonText(
                      text: "1234567890",
                      fontSize: size(context).width * numD04,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size(context).width * numD04),
              Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD03,
                  Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD02,
                  vertical: size(context).width * numD04,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: size(context).width * numD05,
                      backgroundColor: CommonColors.secondaryLightColor,
                      child: Icon(Icons.email_outlined, color: Colors.black),
                    ),

                    SizedBox(width: size(context).width * numD02),

                    CommonText(
                      text: "freestyle@gmail.com",
                      fontSize: size(context).width * numD04,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size(context).width * numD04),
              Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD03,
                  Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size(context).width * numD02,
                    vertical: size(context).width * numD04,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: size(context).width * numD05,
                      backgroundColor: CommonColors.secondaryLightColor,
                      child: Icon(Icons.location_on_outlined, color: Colors.black),
                    ),

                    SizedBox(width: size(context).width * numD02),

                    Expanded(
                      child: CommonText(
                        text: "San Francisco, CA 94103 United States",
                        fontWeight: FontWeight.w500,
                        fontSize: size(context).width * numD04,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size(context).width * numD04),

              Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD03,
                  Colors.white,
                ),
                padding: EdgeInsets.all(size(context).width * numD02),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size(context).width * numD02),

                      CommonText(
                        text: "Enter Details",
                        fontSize: size(context).width * numD04,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      SizedBox(height: size(context).width * numD04),
                      CommonTextFormField(
                        controller: cubit.nameController,
                        filled: true,
                        enableShadow: true,
                        hint: "Name",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Required*";
                          }
                          return null;
                        },
                      ),
                      Divider(),
                      CommonTextFormField(
                        controller: cubit.emailController,
                        filled: true,
                        enableShadow: true,
                        hint: "Email",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Required*";
                          }
                          return null;
                        },
                      ),
                      Divider(),
                      CommonTextFormField(
                        controller: cubit.messageController,
                        filled: true,
                        enableShadow: true,
                        hint: "Message",
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Required*";
                          }
                          return null;
                        },
                      ),
                      Divider(),
                      SizedBox(height: size(context).width * numD04),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size(context).width * numD15),
              CommonButton(text: "Submit", onTap: () {
                if(cubit.formKey.currentState!.validate()){
                  cubit.callContactUsApi();
                }

              }),

              SizedBox(height: size(context).width * numD06),
            ],
          ),
        ),
      );
  },
),
    );
  }
}
