/*
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../generated/assets.dart';
import '../main.dart';
import 'common_constants.dart';
import 'common_widgets/common_text/common_text.dart';







Widget errorImageBuilder(Size size, double value) {
  return Center(
    child: Container(
      height: size.width * value,
      width: size.width * value,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * numD04),
        child: Image.asset(
          Assets.iconsIcAccountPlaceholder,
          height: size.width * numD20,
          width: size.width * numD20,
          color: Colors.grey.shade200,
        ),
      ),
    ),
  );
}

void commonBottomSheet({
  required Size size,
  required BuildContext context,
  required String message,
  required Function onYes,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: size.width * numD40,
              horizontal: size.width * numD05,
            ),
            padding: EdgeInsets.all(size.width * numD03),
            decoration: commonWhiteDecoration(size, numD03),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.question_mark,
                  color: CommonColors.themeColor,
                  size: size.width * numD15,
                ),
                SizedBox(height: size.width * numD035),
                CommonText(
                  textAlign: TextAlign.center,
                  text: message,
                  fontSize: size.width * numD04,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                SizedBox(height: size.width * numD05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    commonShortButton(
                      onTap: () {
                        onYes();
                      },
                      buttonText: "YES",
                      fontSize: size.width * numD03,
                      buttonHeight: size.width * numD07,
                      size: size,
                    ),
                    SizedBox(width: size.width * numD02),
                    commonShortOutlinedButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      buttonText: "NO",
                      fontSize: size.width * numD03,
                      buttonHeight: size.width * numD07,
                      size: size,
                    ),
                  ],
                ),
                SizedBox(height: size.width * numD02),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Common Date Picker ::::
Future<DateTime?> commonDatePicker(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );
  return pickedDate;
}

Future<DateTime?> commonPastDatePicker(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
  );
  return pickedDate;
}

/// Common Time Picker ::::
Future<String> commonTimePicker(BuildContext context) async {
  String time = "";
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: CommonColors.themeColor,
          ),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        ),
      );
    },
  );

  if (pickedTime != null) {
    int _hour = pickedTime.hour.toInt();
    int _minute = pickedTime.minute.toInt();
    time =
        "${_hour.toString().length == 1 ? "0$_hour" : _hour}:${_minute.toString().length == 1 ? "0$_minute" : _minute}:00";
  }
  return time;
}

/// ::::: Common App Bar :::::

AppBar commonAppBar({
  required GlobalKey<ScaffoldState> scaffoldKey,
  required bool showDrawer,
  required bool showBack,
  required bool showSearch,
  required bool showNotification,
  required bool showProfile,
  required bool showLogo,
  required Size size,
  required Function onTapBack,
  required Function onTapTitle,
  required Function onTapSearch,
  required Function onTapNotification,
  required Function onTapProfile,
  required bool isBottom,
}) {
  return AppBar(
    elevation: 1,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    toolbarHeight: size.width * numD15,
    leadingWidth: size.width * numD20,
    leading: Row(
      children: [
        SizedBox(width: size.width * numD02),
        Visibility(
          visible: showDrawer,
          child: InkWell(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.width * numD03),
              child: Image(
                image: AssetImage(Assets.iconsIcDrawer),
                width: size.width * numD07,
                height: size.width * numD07,
              ),
            ),
          ),
        ),
        Visibility(
          visible: showBack,
          child: IconButton(
            splashRadius: size.width * numD06,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                CommonColors.textFormFieldColor.withOpacity(0.1),
              ),
              side: const MaterialStatePropertyAll(
                BorderSide(color: Colors.transparent),
              ),
            ),
            highlightColor: CommonColors.greyColor,
            splashColor: Colors.transparent,
            icon: Image(
              image: AssetImage(Assets.iconsBack),
              width: size.width * numD1,
              height: size.width * numD1,
            ),
            onPressed: () {
              onTapBack();
            },
          ),
        ),
        SizedBox(width: size.width * numD03),
        Visibility(
          visible: showLogo,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: size.width * numD03),
            child: Image(
              image: AssetImage(Assets.iconsIcLogout),
              width: size.width * numD07,
              height: size.width * numD07,
            ),
          ),
        ),
      ],
    ),
    title: InkWell(
      onTap: () {
        onTapTitle();
      },
      child: Container(
        decoration: BoxDecoration(
          color: CommonColors.secondaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(size.width * numD02),
        ),
        padding: EdgeInsets.all(size.width * numD02),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor:
                  sharedPreferences.getBool(PreferenceKeys.isAtHome) ?? false
                  ? CommonColors.successColor.withOpacity(0.2)
                  : CommonColors.greyColor.withOpacity(0.2),
              radius: size.width * numD025,
              child: CircleAvatar(
                backgroundColor:
                    sharedPreferences.getBool(PreferenceKeys.isAtHome) ?? false
                    ? CommonColors.successColor.withOpacity(0.7)
                    : CommonColors.greyColor.withOpacity(0.7),
                radius: size.width * numD015,
              ),
            ),
            SizedBox(width: size.width * numD02),
            Image.asset(
              Assets.iconsIcArrowDown,
              width: size.width * numD04,
              height: size.width * numD04,
            ),
          ],
        ),
      ),
    ),
    centerTitle: true,
    automaticallyImplyLeading: false,
    actions: [
      /// Search ::
      Visibility(
        visible: showSearch,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: CommonColors.themeColor.withOpacity(0.2),
          child: Container(
            padding: EdgeInsets.all(size.width * numD015),
            margin: EdgeInsets.all(size.width * numD01),
            decoration: commonWhiteDecoration(size, size.width * numD1),
            child: Image(
              image: AssetImage(Assets.iconsIcSearch),
              width: size.width * numD05,
              height: size.width * numD05,
            ),
          ),
          onTap: () {
            onTapSearch();
          },
        ),
      ),

      /// Notification ::
      Visibility(
        visible: showNotification,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: CommonColors.themeColor.withOpacity(0.2),
          onTap: () {
            onTapNotification();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(size.width * numD015),
                margin: EdgeInsets.all(size.width * numD01),
                decoration: commonWhiteDecoration(size, size.width * numD1),
                child: Image(
                  image: AssetImage(Assets.iconsIcNotificationColor),
                  width: size.width * numD05,
                  height: size.width * numD05,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: size.width * numD025,
                  child: CommonText(
                    text: "10",
                    color: Colors.white,
                    fontSize: size.width * numD025,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// Profile :::
      Visibility(
        visible: showProfile,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: CommonColors.themeColor.withOpacity(0.2),
          child: Container(
            padding: EdgeInsets.all(size.width * numD015),
            margin: EdgeInsets.all(size.width * numD01),
            decoration: commonWhiteDecoration(size, size.width * numD1),
            child: Image(
              image: AssetImage(Assets.iconsIcProfileColor),
              width: size.width * numD05,
              height: size.width * numD05,
            ),
          ),
          onTap: () {
            onTapProfile();
          },
        ),
      ),

      SizedBox(width: size.width * numD02),
    ],
    shape: Border(
      bottom: isBottom
          ? BorderSide(
              color: CommonColors.greyColor.withOpacity(0.36),
              width: 1,
            )
          : const BorderSide(color: Colors.transparent, width: 0),
    ),
  );
}

AppBar commonNormalAppBar({
  required Size size,
  required String appBarTitle,
  required bool showFilterButton,
  required bool showHistoryButton,
  required bool showFavouriteButton,
  required bool showAddButton,
  bool showWingApartmentButton = false,
  bool showEdit = false,
  required Function onTapBack,
  required Function onTapFilter,
  required Function onTapHistory,
  required Function onTapFavourite,
  required Function onTapAdd,
  Function? onTapWingApartment,
  Function? onTapEdit,
}) {
  return AppBar(
    elevation: 1,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    toolbarHeight: size.width * numD15,
    leadingWidth: size.width * numD15,
    leading: IconButton(
      splashRadius: size.width * numD06,
      isSelected: false,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          CommonColors.textFormFieldColor.withOpacity(0.1),
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(color: Colors.transparent),
        ),
      ),
      highlightColor: CommonColors.splashColor,
      splashColor: Colors.transparent,
      icon: Container(
        decoration: commonWhiteDecoration(size, size.width * numD09),
        padding: EdgeInsets.all(size.width * numD02),
        child: Image(
          image: AssetImage(Assets.iconsBack),
          width: size.width * numD05,
          height: size.width * numD05,
        ),
      ),
      onPressed: () {
        onTapBack();
      },
    ),
    title: CommonText(
      text: appBarTitle,
      fontSize: size.width * numD04,
      color: CommonColors.themeColor,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
    automaticallyImplyLeading: false,
    actions: [
      /// Add ::
      Visibility(
        visible: showAddButton,
        child: IconButton(
          splashRadius: size.width * numD06,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              CommonColors.textFormFieldColor.withOpacity(0.1),
            ),
            side: const MaterialStatePropertyAll(
              BorderSide(color: Colors.transparent),
            ),
          ),
          highlightColor: CommonColors.splashColor,
          splashColor: Colors.transparent,
          icon: Container(
            decoration: commonWhiteDecoration(size, size.width * numD09),
            padding: EdgeInsets.all(size.width * numD02),
            child: Image(
              image: AssetImage(Assets.iconsIcAdd),
              height: size.width * numD05,
              width: size.width * numD05,
            ),
          ),
          onPressed: () {
            onTapAdd();
          },
        ),
      ),

      /// Edit ::
      Visibility(
        visible: showEdit,
        child: IconButton(
          splashRadius: size.width * numD06,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              CommonColors.textFormFieldColor.withOpacity(0.1),
            ),
            side: const MaterialStatePropertyAll(
              BorderSide(color: Colors.transparent),
            ),
          ),
          highlightColor: CommonColors.splashColor,
          splashColor: Colors.transparent,
          icon: Container(
            decoration: commonWhiteDecoration(size, size.width * numD09),
            padding: EdgeInsets.all(size.width * numD02),
            child: Icon(
              Icons.edit,
              color: CommonColors.themeColor,
              size: size.width * numD05,
            ),
          ),
          onPressed: () {
            if (onTapEdit != null) {
              onTapEdit();
            }
          },
        ),
      ),

      /// Filter ::
      Visibility(
        visible: showFilterButton,
        child: IconButton(
          splashRadius: size.width * numD06,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              CommonColors.textFormFieldColor.withOpacity(0.1),
            ),
            side: const MaterialStatePropertyAll(
              BorderSide(color: Colors.transparent),
            ),
          ),
          highlightColor: CommonColors.splashColor,
          splashColor: Colors.transparent,
          icon: Container(
            decoration: commonWhiteDecoration(size, size.width * numD09),
            padding: EdgeInsets.all(size.width * numD02),
            child: Image(
              image: AssetImage(Assets.iconsIcFilter),
              height: size.width * numD05,
              width: size.width * numD05,
            ),
          ),
          onPressed: () {
            onTapFilter();
          },
        ),
      ),

      /// Fav ::
      Visibility(
        visible: showFavouriteButton,
        child: IconButton(
          splashRadius: size.width * numD06,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              CommonColors.textFormFieldColor.withOpacity(0.1),
            ),
            side: const MaterialStatePropertyAll(
              BorderSide(color: Colors.transparent),
            ),
          ),
          highlightColor: CommonColors.splashColor,
          splashColor: Colors.transparent,
          icon: Container(
            decoration: commonWhiteDecoration(size, numD09),
            padding: EdgeInsets.all(size.width * numD015),
            margin: EdgeInsets.symmetric(vertical: size.width * numD014),
            child: Image.asset(
              Assets.iconsIcStarFilled,
              height: size.width * numD05,
              width: size.width * numD05,
            ),
          ),
          onPressed: () {
            onTapFavourite();
          },
        ),
      ),
    ],
  );
}

class CustomGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Decoration? backgroundDecoration;
  final TextStyle? titleStyle;
  final double height;
  final bool centerTitle;

  const CustomGradientAppBar({
    super.key,
    required this.context,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.backgroundDecoration,
    this.titleStyle,
    this.height = kToolbarHeight,
    this.centerTitle = false,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height + size(context).width * numD06);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle =
        titleStyle ??
        theme.textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: size(context).width * numD055,
          fontWeight: FontWeight.w600,
        );

    return Container(
      decoration:
          backgroundDecoration ??
          const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SizedBox(
        height: kToolbarHeight + size(context).width * numD06,
        child: Stack(
          children: [
            if (showBackButton)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: !centerTitle ? size(context).width * numD04 : 0,
                  ),
                  Text(
                    title,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (actions != null)
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions ?? [],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ::::: Common Button :::::
class CommonButton extends StatefulWidget {
  final Function() onTap;
  final bool isSelectedColor;
  final IconData? icon;
  final IconData? iconAfterText;
  final bool isBorderColor;
  final String buttonText;
  double? radius;
  double buttonSize;
  FontWeight? fontWeight;
  Color? borderColor;
  Color? bgColor;
  Color? buttonTextColor;

  CommonButton({
    super.key,
    required this.onTap,
    required this.isSelectedColor,
    this.icon,
    this.radius,
    this.iconAfterText,
    this.fontWeight = FontWeight.w400,
    this.buttonSize = numD04,
    required this.isBorderColor,
    required this.buttonText,
    this.borderColor,
    this.bgColor,
    this.buttonTextColor,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          size.width * (widget.radius ?? numD08),
        ),
        gradient: const LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
        ),
        border: Border.all(
          color: widget.isBorderColor
              ? widget.borderColor ?? CommonColors.lightGreyColor
              : Colors.transparent,
        ),
      ),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              size.width * (widget.radius ?? numD09),
            ),
          ),
          backgroundColor: widget.bgColor ?? CommonColors.themeColor,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: size.width * numD03),
        ),
        child: widget.icon != null || widget.iconAfterText != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.icon != null
                      ? Icon(
                          widget.icon!,
                          color: CommonColors.secondaryColor,
                          size: size.width * numD055,
                        )
                      : const SizedBox.shrink(),
                  SizedBox(width: size.width * numD02),
                  Text(
                    widget.buttonText,
                    style: TextStyle(
                      color: widget.buttonTextColor ?? CommonColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: fontFamily,
                      fontSize: size.width * widget.buttonSize,
                    ),
                  ),
                  SizedBox(width: size.width * numD02),
                  widget.iconAfterText != null
                      ? Icon(
                          widget.iconAfterText!,
                          color: widget.buttonTextColor ?? CommonColors.blackColor,
                          size: size.width * numD055,
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : Text(
                widget.buttonText,
                style: TextStyle(
                  color: widget.buttonTextColor ?? CommonColors.blackColor,
                  fontWeight: widget.fontWeight,
                  fontFamily: fontFamily,
                  fontSize: size.width * widget.buttonSize,
                ),
              ),
      ),
    );
  }
}

/// Short Filled button ::

Widget commonTextButton({
  required Function() onTap,
  required Size size,
  required String buttonText,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextButton(
    onPressed: () {
      onTap();
    },
    child: CommonText(
      text: buttonText,
      fontSize: fontSize ?? size.width * numD035,
      fontWeight: fontWeight ?? FontWeight.w500,
      textAlign: TextAlign.center,
      color: color ?? Colors.black,
    ),
  );
}

Widget commonOutlinedButton({
  required Function() onTap,
  required Size size,
  required Widget buttonText,
  double? radius,
  double? buttonHeight,
  double? horizontalPadding,
  Color? borderColor,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD07,
    width: size.width,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? CommonColors.themeColor),
          borderRadius: BorderRadius.circular(size.width * (radius ?? numD05)),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: buttonText,
    ),
  );
}

Widget commonRadio(Size size, Color activeColor) {
  return CircleAvatar(
    backgroundColor: CommonColors.themeColor,
    radius: size.width * numD03,
    child: CircleAvatar(
      radius: size.width * numD028,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: size.width * numD022,
        backgroundColor: activeColor,
      ),
    ),
  );
}

Widget commonRadioHome(Size size, Color activeColor) {
  return CircleAvatar(
    backgroundColor: activeColor.withOpacity(0.2),
    radius: size.width * numD03,
    child: CircleAvatar(
      backgroundColor: activeColor.withOpacity(0.7),
      radius: size.width * numD022,
    ),
  );
}

Center bottomSheetLine(Size size) {
  return Center(
    child: Container(
      height: size.width * numD01,
      width: size.width * numD30,
      decoration: BoxDecoration(
        color: CommonColors.themeColor,
        borderRadius: BorderRadius.circular(size.width * numD02),
      ),
      margin: EdgeInsets.only(bottom: size.width * numD05),
    ),
  );
}

BoxDecoration commonDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonDecorationTopOnly(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonWhiteDecorationTopOnly(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonTabDecorationTopOnly(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.themeColor.withOpacity(0.1),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonWhiteDecoration(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border(
      left: BorderSide(
        width: size.width * numD01,
        color: CommonColors.secondaryColor,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: size.width * numD003,
        //spreadRadius: size.width * numD003,
      ),
    ],
  );
}

BoxDecoration commonSideColorDecoration(Size size, double radius, Color color) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border(
      left: BorderSide(width: size.width * numD01, color: color),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: size.width * numD003,
        //spreadRadius: size.width * numD003,
      ),
    ],
  );
}

BoxDecoration commonLightWhiteDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.secondaryLightColor,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border(
      left: BorderSide(
        width: size.width * numD01,
        color: CommonColors.secondaryColor,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: size.width * numD003,
        //spreadRadius: size.width * numD003,
      ),
    ],
  );
}

BoxDecoration commonSelectedBottomDecoration(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgLightWhiteDecoration(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white.withValues(alpha: 0.3),
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgGreyDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor.withValues(alpha: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgLightGreyDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor.withValues(alpha: 0.1),
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration commonBgLightGreyTopOnlyDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor.withValues(alpha: 0.1),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonBgColorTopOnlyDecoration(
  Size size,
  Color color,
  double radius,
) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration commonBgColorDecoration(Size size, double radius, Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}











ShapeDecoration commonCardDecoration(Size size, double radius) {
  return ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),

    shadows: const [
      BoxShadow(
        color: Color(0x19000000),
        blurRadius: 7,
        offset: Offset(0, 0),
        spreadRadius: 0,
      ),
    ],
  );
}

ShapeDecoration commonCardBottomRoundDecoration(Size size, double radius) {
  return ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(size.width * radius),
        bottomRight: Radius.circular(size.width * radius),
      ),
    ),
    shadows: const [
      BoxShadow(
        color: Color(0x19000000),
        blurRadius: 7,
        offset: Offset(0, 0),
        spreadRadius: 0,
      ),
    ],
  );
}

BoxDecoration enabledDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.themeColor,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration disabledDecoration(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
  );
}

BoxDecoration disabledDecorationTopOnly(Size size, double radius) {
  return BoxDecoration(
    color: CommonColors.lightGreyColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
  );
}

BoxDecoration outlinedDecoration(Size size, double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border.all(color: CommonColors.secondaryColor),
  );
}

BoxDecoration outlinedAndInnerDecoration(
  Size size,
  Color innerColor,
  Color borderColor,
  double radius,
) {
  return BoxDecoration(
    color: innerColor,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border.all(color: borderColor),
  );
}

BoxDecoration outlinedGreyDecoration(Size size, double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    border: Border.all(color: Colors.grey.shade400),
  );
}

BoxDecoration cardDecoration(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: size.width * numD01,
        spreadRadius: size.width * numD01,
      ),
    ],
  );
}

Widget commonShortButtonWithIcon({
  required Function() onTap,
  required Size size,
  required String buttonText,
  required Widget iconWidget,
  Color? buttonColor,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  double? buttonHeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD05,
    child: ElevatedButton.icon(
      icon: iconWidget,
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? size.width * numD01),
        ),
        backgroundColor: buttonColor ?? CommonColors.themeColor,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      label: Text(
        buttonText,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget commonShortButton({
  required Function() onTap,
  required Size size,
  required String buttonText,
  Color? buttonColor,
  Color? textColor,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  double? buttonHeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD05,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? size.width * numD01),
        ),
        backgroundColor: buttonColor ?? CommonColors.themeColor,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: textColor ?? CommonColors.blackColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget commonShortButtonWidth({
  required Function() onTap,
  required Size size,
  required String buttonText,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  double? buttonHeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD05,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? size.width * numD01),
        ),
        backgroundColor: CommonColors.themeColor,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget commonShortOutlinedButton({
  required Function() onTap,
  required Size size,
  required String buttonText,
  Color? buttonColor,
  double? radius,
  double? fontSize,
  double? buttonHeight,
  FontWeight? fontWeight,
  double? horizontalPadding,
}) {
  return SizedBox(
    height: buttonHeight ?? size.width * numD05,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: buttonColor ?? CommonColors.themeColor),
          borderRadius: BorderRadius.circular(radius ?? (size.width * numD01)),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: horizontalPadding ?? size.width * numD03,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonColor ?? CommonColors.themeColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

BoxDecoration cardDecorationLightGrey(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(size.width * radius)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        blurRadius: size.width * numD01,
        spreadRadius: size.width * numD01,
      ),
    ],
  );
}

BoxDecoration cardDecorationBottom(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(size.width * radius),
      bottomRight: Radius.circular(size.width * radius),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        blurRadius: size.width * numD01,
        spreadRadius: size.width * numD01,
      ),
    ],
  );
}

Widget dottedLine(Size size) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: size.width * numD03,
      horizontal: size.width * numD01,
    ),
    child: Row(
      children: List.generate(
        150 ~/ 1.2,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
            height: 1.4,
          ),
        ),
      ),
    ),
  );
}

Widget dottedLineLightest(Size size) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: size.width * numD03,
      horizontal: size.width * numD01,
    ),
    child: Row(
      children: List.generate(
        150 ~/ 1.2,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade200,
            height: 1.4,
          ),
        ),
      ),
    ),
  );
}

Widget dottedLineSmall(Size size) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: size.width * numD03,
      horizontal: size.width * numD01,
    ),
    child: Row(
      children: List.generate(
        30 ~/ 1.2,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
            height: 1.4,
          ),
        ),
      ),
    ),
  );
}

Widget dottedLineMedium(Size size) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: size.width * numD03,
      horizontal: size.width * numD01,
    ),
    child: Row(
      children: List.generate(
        50 ~/ 1.2,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
            height: 1.4,
          ),
        ),
      ),
    ),
  );
}

/// successDialog
void showSuccessAlertDialog(BuildContext context) {
  var size = MediaQuery.of(context).size;

  Future.delayed(const Duration(seconds: 3), () {
    debugPrint("::::POP::::");
    Navigator.maybePop(context);
  });

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * numD05),
            decoration: commonWhiteDecoration(size, numD03),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width * numD02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: size.width / 2,
                    width: size.width,
                    color: Colors.green,
                    child: Icon(
                      Icons.check_circle,
                      size: size.width * numD25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.width * numD035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        text: "REQUEST SUBMITTED",
                        color: CommonColors.themeColor,
                        fontSize: size.width * numD04,
                      ),
                      SizedBox(width: size.width * numD02),
                      Image.asset(
                        Assets.iconsIcCheck,
                        height: size.width * numD04,
                        width: size.width * numD04,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * numD01),
                  CommonText(
                    text: "Your request has been submitted successfully!",
                    fontSize: size.width * numD035,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: size.width * numD05),
                  commonShortButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    buttonText: "DONE",
                    fontSize: size.width * numD03,
                    buttonHeight: size.width * numD07,
                    size: size,
                  ),
                  SizedBox(height: size.width * numD05),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

BoxDecoration cardDecorationTop(Size size, double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(size.width * radius),
      topRight: Radius.circular(size.width * radius),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        blurRadius: size.width * numD01,
        spreadRadius: size.width * numD01,
      ),
    ],
  );
}

Widget commonLoader() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(CommonColors.themeColor),
    ),
  );
}

Widget commonDropDown({
  required Size size,
  required List<ItemModel> itemList,
  required ItemModel initialItem,
  required Function onChange,
}) {
  return CustomDropdown<ItemModel>(
    hintText: 'Select Option',
    items: itemList,
    initialItem: initialItem,
    decoration: CustomDropdownDecoration(
      closedBorder: Border.all(color: CommonColors.lightGreyColor, width: 1),
      expandedBorderRadius: BorderRadius.circular(size.width * numD02),
      closedBorderRadius: BorderRadius.circular(size.width * numD02),
    ),
    onChanged: (value) {
      onChange(value);
    },
    headerBuilder: (context, item, value) {
      return Container(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Icon(item.icon, color: CommonColors.secondaryColor),
            SizedBox(width: size.width * numD02),
            CommonText(
              text: item.name,
              color: CommonColors.secondaryColor,
              fontSize: size.width * numD035,
            ),
          ],
        ),
      );
    },
    listItemBuilder: (context, item, value, function) {
      return Container(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Icon(item.icon, color: CommonColors.secondaryColor),
            SizedBox(width: size.width * numD02),
            CommonText(
              text: item.name,
              color: CommonColors.secondaryColor,
              fontSize: size.width * numD035,
            ),
          ],
        ),
      );
    },
  );
}

Widget commonDropDownString({
  required Size size,
  required List<String> itemList,
  required String initialItem,
  required Function onChange,
}) {
  return CustomDropdown<String>(
    hintText: 'Select Option',
    items: itemList,
    initialItem: initialItem,
    decoration: CustomDropdownDecoration(
      closedBorder: Border.all(color: CommonColors.lightGreyColor, width: 1),
      expandedBorderRadius: BorderRadius.circular(size.width * numD02),
      closedBorderRadius: BorderRadius.circular(size.width * numD02),
    ),
    onChanged: (value) {
      onChange(value);
    },
    headerBuilder: (context, item, value) {
      return Container(
        padding: EdgeInsets.zero,
        child: CommonText(
          text: item,
          color: CommonColors.secondaryColor,
          fontSize: size.width * numD035,
        ),
      );
    },
    listItemBuilder: (context, item, value, function) {
      return Container(
        padding: EdgeInsets.zero,
        child: CommonText(
          text: item,
          color: CommonColors.secondaryColor,
          fontSize: size.width * numD035,
        ),
      );
    },
  );
}

Widget commonDropDown2String({
  required Size size,
  required List<String> itemList,
  required String initialItem,
  required Function onChange,
}) {
  return Container(
    height: size.width * 0.14,
    // padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
    decoration: BoxDecoration(
      border: Border.all(color: CommonColors.secondaryColor, width: 1.7),
      borderRadius: BorderRadius.circular(size.width * numD02),
    ),
    child: CustomDropdown<String>(
      hintText: 'Select Option',
      items: itemList,
      initialItem: initialItem,
      decoration: CustomDropdownDecoration(
        expandedBorderRadius: BorderRadius.zero,
        closedBorder: Border.fromBorderSide(BorderSide.none),
        closedBorderRadius: BorderRadius.circular(size.width * numD02),
      ),
      onChanged: (value) {
        onChange(value);
      },
      headerBuilder: (context, item, value) {
        return Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            text: item,
            color: CommonColors.secondaryColor,
            fontSize: size.width * numD035,
          ),
        );
      },
      listItemBuilder: (context, item, isSelected, onItemTap) {
        return InkWell(
          onTap: onItemTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.width * 0.03),
            child: CommonText(
              text: item,
              color: CommonColors.secondaryColor,
              fontSize: size.width * numD035,
            ),
          ),
        );
      },
    ),
  );
}

Widget commonLinearProgress({
  required BuildContext context,
  required double value,
  required Color bgColor,
  required Color valueColor,
}) {
  return Shimmer.fromColors(
    baseColor: bgColor,
    highlightColor: Colors.white.withValues(alpha: 0.7),
    direction: ShimmerDirection.ltr,
    period: const Duration(seconds: 6),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(size(context).width * numD02),
      child: LinearProgressIndicator(
        value: value,
        minHeight: size(context).width * numD02,
        backgroundColor: bgColor.withValues(alpha: 0.3),
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
      ),
    ),
  );
}

Widget commonNormalLinearProgress({
  required BuildContext context,
  required double value,
  required Color bgColor,
  required Color valueColor,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(size(context).width * numD02),
    child: LinearProgressIndicator(
      value: value,
      minHeight: size(context).width * numD02,
      backgroundColor: bgColor.withValues(alpha: 0.3),
      valueColor: AlwaysStoppedAnimation<Color>(valueColor),
    ),
  );
}

Widget commonImgDropDown({
  required Size size,
  required List<ItemImageModel> itemList,
  required ItemImageModel initialItem,
  required Function onChange,
}) {
  return CustomDropdown<ItemImageModel>(
    hintText: 'Select Option',
    items: itemList,
    initialItem: initialItem,
    decoration: CustomDropdownDecoration(
      closedBorder: Border.all(color: CommonColors.lightGreyColor, width: 1),
      expandedBorderRadius: BorderRadius.circular(size.width * numD02),
      closedBorderRadius: BorderRadius.circular(size.width * numD02),
    ),
    onChanged: (value) {
      onChange(value);
    },
    headerBuilder: (context, item, value) {
      return Container(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Image.asset(
              item.icon as String,
              color: CommonColors.secondaryColor,
            ),
            SizedBox(width: size.width * numD02),
            CommonText(
              text: item.name,
              color: CommonColors.secondaryColor,
              fontSize: size.width * numD035,
            ),
          ],
        ),
      );
    },
    listItemBuilder: (context, item, value, function) {
      return Container(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Image.asset(
              item.icon as String,
              color: CommonColors.secondaryColor,
            ),
            SizedBox(width: size.width * numD02),
            CommonText(
              text: item.name,
              color: CommonColors.secondaryColor,
              fontSize: size.width * numD035,
            ),
          ],
        ),
      );
    },
  );
}

Widget commonSearchDropDownString({
  required Size size,
  required List<String> itemList,
  required String initialItem,
  required Function onChange,
}) {
  return CustomDropdown<String>.search(
    hintText: 'Select Option',
    items: itemList,
    initialItem: initialItem,
    excludeSelected: false,
    decoration: CustomDropdownDecoration(
      closedBorder: Border.all(color: CommonColors.lightGreyColor, width: 1),
      expandedBorderRadius: BorderRadius.circular(size.width * numD02),
      closedBorderRadius: BorderRadius.circular(size.width * numD02),
    ),
    onChanged: (value) {
      onChange(value);
    },
    headerBuilder: (context, item, value) {
      return Container(
        padding: EdgeInsets.zero,
        child: CommonText(
          text: item,
          color: CommonColors.secondaryColor,
          fontSize: size.width * numD035,
        ),
      );
    },
    listItemBuilder: (context, item, value, function) {
      return Container(
        padding: EdgeInsets.zero,
        child: CommonText(
          text: item,
          color: CommonColors.secondaryColor,
          fontSize: size.width * numD035,
        ),
      );
    },
  );
}

class DecimalTextInputFormatter extends TextInputFormatter {
  final NumberFormat formatter;

  DecimalTextInputFormatter({required this.formatter});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    newText = formatter.format(int.parse(newText));

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ItemModel {
  IconData icon;
  String name = "";
  String? description = "";
  bool isSelected = false;

  ItemModel({
    required this.icon,
    this.description,
    required this.name,
    required this.isSelected,
  });
}

class ItemImageModel {
  Image icon;
  String name = "";
  String? description = "";
  bool isSelected = false;

  ItemImageModel({
    required this.icon,
    this.description,
    required this.name,
    required this.isSelected,
  });
}
*/
