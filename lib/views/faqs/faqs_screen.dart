import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/views/faqs/faqs_cubit.dart';

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
    return BlocBuilder<FaqsCubit, FaqState>(
      builder: (context, state) {
        var cubit = context.read<FaqsCubit>();
        return Scaffold(
          appBar: const CommonAppBar(title: "FAQs", showBack: true),
          body: ListView.separated(
            padding: EdgeInsets.symmetric(
              vertical: size(context).width * numD04,
              horizontal: size(context).width * numD04,
            ),
            itemBuilder: (context, index) {
              final faq = cubit.faqList[index];
              return Container(
                decoration: commonOutlineDecoration(
                  size(context).width * numD03,
                  1,
                  Colors.white.withOpacity(0.2),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: CommonColors.secondaryColor,
                    collapsedIconColor: Colors.white,
                    leading: Container(
                      decoration: commonBgColorDecoration(
                        size(context).width * numD01,
                        Colors.white,
                      ),
                      width: size(context).width * numD08,
                      height: size(context).width * numD08,
                      alignment: Alignment.center,
                      child: CommonText(
                        text: "Q",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size(context).width * numD045,
                      ),
                    ),
                    title: CommonText(
                      text: faq.title ?? "",
                      maxLines: 3,
                      fontWeight: FontWeight.w500,
                      fontSize: size(context).width * numD04,
                    ),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                    children: [
                      if (faq.description.toString().contains("<p>"))
                        Html(
                          data: faq.description,
                          style: {
                            "body": Style(
                              fontSize: FontSize(size(context).width * numD035),
                              color: Colors.white.withOpacity(0.8),
                            ),
                          },
                        )
                      else
                        CommonText(
                          text: faq.description ?? "",
                          fontSize: size(context).width * numD035,
                          color: Colors.white.withOpacity(0.8),
                          height: 1.4,
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
            itemCount: cubit.faqList.length,
          ),
        );
      },
    );
  }
}
