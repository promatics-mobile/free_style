import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_tab_bar/common_tab_bar.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

class SkillTreeScreen extends StatelessWidget {
  const SkillTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Skill Tree", actions: []),
      body: CommonTabBar(
        tabs: ["Lower", "Upper", "Ground", "Sit Down"],
        views: [
          lowerWidget(context),
          lowerWidget(context),
          lowerWidget(context),
          lowerWidget(context),
        ],
        isScrollable: true,
      ),
    );
  }

  Widget lowerWidget(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stepper(
            type: StepperType.vertical,

            connectorColor: WidgetStatePropertyAll(
              CommonColors.secondaryLightColor,
            ),
            stepIconBuilder: (i, s) {
              return Icon(Icons.check_circle);
            },
            steps: [
              Step(
                isActive: true,
                title: CommonText(text: "Basic Touch Control"),
                content: Container(),
              ),
              Step(
                isActive: false,
                title: CommonText(text: "Crossover Control"),
                content: Container(),
              ),
              Step(
                isActive: false,
                title: CommonText(text: "Around the World (ATW)"),
                content: Container(),
              ),
            ],
          ),
          CommonText(text: "Around the World"),
          CommonText(text: "Lower branch b7 Tier 2"),
        ],
      ),
    );
  }
}
