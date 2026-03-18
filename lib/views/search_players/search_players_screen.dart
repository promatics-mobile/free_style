import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:free_style/views/search_players/search_players_cubit.dart';

import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class SearchPlayersScreen extends StatelessWidget {
  const SearchPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPlayersCubit, SearchPlayersState>(
      builder: (context, state) {
        var cubit = context.read<SearchPlayersCubit>();
        return Scaffold(
          appBar: CommonAppBar(title: "Search Players", showBack: true),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextFormField(
                  filled: true,
                  controller: cubit.searchPlayerController,
                  enableShadow: true,
                  hint: "Search Player",
                  keyboardType: TextInputType.text,
                  borderRadius: BorderRadius.circular(size(context).width * numD04),
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(horizontal: size(context).width * numD03),
                    child: Icon(Icons.search, color: CommonColors.buttonColor),
                  ),

                  onChanged: (v) {
                    cubit.callPlayerListApi(isRefresh: true);
                  },
                  suffixIcon: InkWell(
                    onTap: () {
                      cubit.searchPlayerController.clear();
                      cubit.callPlayerListApi(isRefresh: true);
                    },
                    child: Icon(Icons.cancel_outlined, color: Colors.black),
                  ),
                ),
                SizedBox(height: size(context).width * numD02),
                CommonText(
                  text: "Search Results",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD04,
                ),
                SizedBox(height: size(context).width * numD02),
                Expanded(
                  child: CommonRefreshIndicator(
                    onRefresh: () async {
                      cubit.callPlayerListApi(isRefresh: true);
                    },
                    onLoadMore: () async {
                      cubit.callPlayerListApi();
                    },
                    child: ListView.builder(
                      itemCount: state.userList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: size(context).width * numD02),
                      itemBuilder: (context, idx) {
                        final user = state.userList[idx];

                        return InkWell(
                          onTap: () {
                            router.push(AppRouter.otherProfileScreen, extra: {"userId": user.sId});

                            debugPrint("userId:::: ${user.sId}");
                          },
                          child: Container(
                            decoration: commonBgColorDecoration(
                              size(context).width * numD04,
                              Colors.white,
                            ),
                            padding: EdgeInsets.all(size(context).width * numD04),
                            margin: EdgeInsets.symmetric(vertical: size(context).width * numD01),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CommonImage(
                                    imagePath: user.avatar?.picture?.isNotEmpty == true
                                        ? user.avatar!.picture!.first.fullPath ?? ""
                                        : "",
                                    width: size(context).width * numD1,
                                    height: size(context).width * numD1,
                                    isNetwork: true,
                                  ),
                                ),

                                SizedBox(width: size(context).width * numD02),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: user.name ?? "",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size(context).width * numD04,
                                    ),
                                    Container(
                                      decoration: commonBgColorDecoration(
                                        size(context).width * numD04,
                                        CommonColors.secondaryColor,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size(context).width * numD02,
                                      ),
                                      child: CommonText(
                                        text: "SILVER ${user.level ?? 0}",
                                        color: Colors.black,
                                        fontSize: size(context).width * numD03,
                                      ),
                                    ),
                                  ],
                                ),

                                Spacer(),

                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: size(context).width * numD04,
                                ),
                                //
                                // /// 🔥 Dynamic Button
                                // commonShortButton(
                                //   onTap: () {
                                //     cubit.handleButtonTap(user);
                                //   },
                                //   size: size(context),
                                //   buttonHeight:
                                //   size(context).width * numD10,
                                //   buttonText: cubit.getButtonText(user),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
