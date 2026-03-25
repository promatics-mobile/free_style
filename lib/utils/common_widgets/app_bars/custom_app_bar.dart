import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

import '../../../routes/route.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final bool centerTitle;
  final Widget? titleWidget;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.centerTitle = true,
    this.titleWidget,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: titleWidget ??
      CommonText(text: title,
        fontSize: size(context).width * numD045,
        fontWeight: FontWeight.w500,),
      backgroundColor: CommonColors.themeColor,
      centerTitle: centerTitle,
      leading: showBack
          ? IconButton(
        icon: const Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: () => router.pop(),
      )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}