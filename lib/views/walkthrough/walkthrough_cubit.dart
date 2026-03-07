import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/views/walkthrough/walkthrough_model.dart';
import 'package:free_style/views/walkthrough/walkthrough_state.dart';
import '../../generated/assets.dart';
import '../../routes/route.dart';

class WalkthroughCubit extends Cubit<WalkthroughState> {
  List<WalkthroughModel> walkthroughList = [];
  var controller = PageController(keepPage: true, initialPage: 0);

  WalkthroughCubit() : super(WalkthroughState(currentPage: 0)) {
     walkthroughList = [
      WalkthroughModel(
        image: Assets.iconsWalk1,
        title: "Connect Instantly",
        description:
        "Join our community of like-minded individuals and share your journey together.",
      ),
      WalkthroughModel(
        image: Assets.iconsWalk2,
        title: "Secure & Private",
        description:
        "Your data is encrypted and safe. You have full control over what you share.",
      ),
      WalkthroughModel(
        image: Assets.iconsWalk3,
        title: "Start Your Journey",
        description:
        "Ready to explore? Create an account today and get access to exclusive features.",
      ),
    ];

    controller.addListener(() {
      emit(state.copyWith(currentPage: controller.page ?? 0));
      debugPrint("CurrentPage: ${state.currentPage}");

    });
  }


  void goToNextBack(String type) {
    debugPrint("type::::: $type");
    if (type == "next") {
      if (state.currentPage < walkthroughList.length - 1) {
        state.currentPage += 1;
        controller.jumpToPage(state.currentPage.toInt());
      } else if (state.currentPage == walkthroughList.length - 1) {
        router.go(AppRouter.logInScreen);
      }
    } else {
      if (state.currentPage > 0) {
        state.currentPage -= 1;
        controller.jumpToPage(state.currentPage.toInt());
      }
    }

    emit(state.copyWith(currentPage: state.currentPage));

    debugPrint("ThePageNumber: ${state.currentPage}");
  }
}
