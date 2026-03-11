import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/views/walkthrough/walkthrough_cubit.dart';
import 'package:free_style/views/walkthrough/walkthrough_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../routes/route.dart';
import '../../utils/common_widgets.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class WalkthroughScreen extends StatelessWidget {
  const WalkthroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalkthroughCubit, WalkthroughState>(
      builder: (context, state) {
        var cubit = context.read<WalkthroughCubit>();
        return Scaffold(
          backgroundColor: CommonColors.themeColor,
          body: Column(
            children: [
              SizedBox(height: size(context).width * numD08),

              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    router.pushReplacement(AppRouter.logInScreen);
                  },
                  child: CommonText(
                    text: "Skip",
                    color: Colors.white,
                    fontSize: size(context).width * numD038,
                  ),
                ),
              ),
              SizedBox(height: size(context).width * numD02),
              Expanded(
                child: PageView.builder(
                  controller: cubit.controller,
                  itemCount: cubit.walkthroughList.length,
                  itemBuilder: (context, index) {
                    var item = cubit.walkthroughList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Image.asset(item.image,fit: BoxFit.cover,)),
                        SizedBox(height: size(context).width * numD06),
                        Padding(
                          padding: EdgeInsets.only(
                            left: size(context).width * numD05,
                            right: size(context).width * numD05,
                            top: size(context).width * numD08,
                          ),
                          child: CommonText(
                            text: item.title,
                            textAlign: TextAlign.center,
                            fontSize: size(context).width * numD07,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD05,
                            vertical: size(context).width * numD03,
                          ),
                          child: CommonText(
                            text: cubit.walkthroughList[index].description,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontSize: size(context).width * numD043,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: size(context).width * numD04),
              SmoothPageIndicator(
                controller: cubit.controller,
                count: cubit.walkthroughList.length,
                axisDirection: Axis.horizontal,
                effect: ExpandingDotsEffect(
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.white,
                  radius: size(context).width * numD02,
                  dotHeight: size(context).width * numD02,
                  dotWidth: size(context).width * numD02,
                ),
              ),

              SizedBox(height: size(context).width * numD04),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    cubit.goToNextBack("next");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: size(context).width * numD05,
                    child: Icon(
                      Icons.arrow_forward,
                      size: size(context).width * numD05,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size(context).width * numD04),
            ],
          ),
        );
      },
    );
  }
}
