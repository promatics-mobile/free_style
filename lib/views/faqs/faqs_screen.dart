import 'package:flutter/material.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';

import '../../utils/common_constants.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return FaqsState();
  }
}

class FaqsState extends State<FaqsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "FAQs", showBack: true),
      body: ListView.separated(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: size(context).width * numD04,
          horizontal: size(context).width * numD04,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: commonOutlineDecoration(
              size(context).width * numD03,
              1,
              Colors.white,
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                leading: Container(
                  decoration: commonBgColorDecoration(size(context).width * numD01, Colors.white),
                  width: size(context).width * numD08,
                  height: size(context).width * numD08,
                  alignment: Alignment.center,
                  child: CommonText(text:"Q",
                    color: Colors.black,
                    fontSize: size(context).width * numD05),
                ),
                title: CommonText(
                  text: "When will the App be launched?",
                  maxLines: 2,
                  fontWeight: FontWeight.w500,
                  fontSize: size(context).width * numD04,
                ),
                expandedAlignment: Alignment.centerLeft,
                childrenPadding: EdgeInsetsGeometry.symmetric(
                  horizontal: size(context).width * numD04,
                ),
                children: [
                  CommonText(
                    text:
                        "We will first soft launch in London, and then depending on the volume and business that we generate, we will slowly but gradually launch available in other cities and towns in the UK. We have received great feedback from various people we have spoken to, and are hopeful to take this further in to other parts of the World including USA, Europe, and India.",
                    maxLines: 5,
                    fontSize: size(context).width * numD035,
                  ),
                  SizedBox(height: size(context).width * numD04),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: size(context).width * numD04);
        },
        itemCount: 10,
      ),
    );
  }
}
