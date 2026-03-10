import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import '../main.dart';
import 'common_constants.dart';
import 'common_widgets.dart';
import 'common_widgets/common_text/common_text.dart';


/// Get Image or Camera ::
void imagePickerOptions({
  required BuildContext context,
  required Size size,
  required Function onCamera,
  required Function onGallery,
}) {
  final action = CupertinoActionSheet(
    title: Text(
      "Select an option",
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: size.width * numD05),
    ),
    actions: [
      CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            onCamera();
          },
          child: Text(
            "Camera",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * numD045,
                fontWeight: FontWeight.bold),
          )),
      CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
          onGallery();
        },
        child: Text("Gallery",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * numD045,
                fontWeight: FontWeight.bold)),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        )),
  );
  showCupertinoModalPopup(context: context, builder: (context) => action);
}

/// Click Image ::
Future<XFile?> pickOrClickImage(ImageSource source) async {
  if (Platform.isAndroid) {
    int sdk = await getSdkVersion();
    debugPrint("SDK_Version :: $sdk");
    if (sdk >= 33) {
      bool photoValue = await photoPermission();
      bool cameraValue = await cameraPermission();

      if (photoValue && cameraValue) {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: source);

        if (image != null) {
          return image;
        }
      } else {
        showToast(
          isError: true,
          message: "Permission denied",
        );
        await permission.openAppSettings();
      }
    } else {
      bool storageValue = await storagePermission();
      bool cameraValue = await cameraPermission();
      if (cameraValue && storageValue) {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: source);

        if (image != null) {
          return image;
        }
      } else {
        showToast(
          isError: true,
          message: "Permission denied",
        );
        await permission.openAppSettings();
      }
    }
  } else if (Platform.isIOS) {
    bool storageValue = await storagePermission();
    bool cameraValue = await cameraPermission();
    if (cameraValue && storageValue) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        return image;
      }
    } else {
      showToast(
        isError: true,
        message: "Permission denied",
      );
      await permission.openAppSettings();
    }
  }
  return null;
}

/// Get Image or Video ::
Future<FilePickerResult?> pickImageOrVideo({
  required bool isMultiSelect,
  required FileType fileType,
}) async {

  if (Platform.isAndroid) {
    int sdk = await getSdkVersion();
    debugPrint("SDK_Version :: $sdk");
    if (sdk >= 33) {
      bool photoValue = await photoPermission();
      bool videoValue = await videoPermission();

      if (photoValue && videoValue) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: isMultiSelect, type: fileType,);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
    else {
      bool storageValue = await storagePermission();
      bool cameraValue = await cameraPermission();
      if (cameraValue && storageValue) {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowMultiple: isMultiSelect, type: fileType);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
  }
  else if (Platform.isIOS){
    bool storageValue = await storagePermission();
    bool cameraValue = await cameraPermission();
    if (cameraValue && storageValue) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: isMultiSelect, type: fileType);
      if (result != null) {
        return result;
      }
    } else{
      showToast(isError: true,message: "Permission denied",);
      await permission.openAppSettings();
    }
  }
  return null;

}

Future<FilePickerResult?> pickVideoAndImage({
  required bool isMultiSelect,
}) async {

  if (Platform.isAndroid) {
    int sdk = await getSdkVersion();
    debugPrint("SDK_Version :: $sdk");
    if (sdk >= 33) {
      bool photoValue = await photoPermission();
      bool videoValue = await videoPermission();

      if (photoValue && videoValue) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: isMultiSelect, type: FileType.custom,allowedExtensions: ['mp4','jpg','jpeg','png']);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
    else {
      bool storageValue = await storagePermission();
      bool cameraValue = await cameraPermission();
      if (cameraValue && storageValue) {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowMultiple: isMultiSelect, type: FileType.custom,allowedExtensions: ['mp4','jpg','jpeg','png']);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
  }
  else if (Platform.isIOS){
    bool storageValue = await storagePermission();
    bool cameraValue = await cameraPermission();
    if (cameraValue && storageValue) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: isMultiSelect, type: FileType.custom,allowedExtensions: ['mp4','jpg','jpeg','png']);
      if (result != null) {
        return result;
      }
    } else{
      showToast(isError: true,message: "Permission denied",);
      await permission.openAppSettings();
    }
  }
  return null;

}

Future<FilePickerResult?> pickCsvFile() async {

  if (Platform.isAndroid) {
    int sdk = await getSdkVersion();
    debugPrint("SDK_Version :: $sdk");
    if (sdk >= 33) {
      bool photoValue = await photoPermission();
      bool videoValue = await videoPermission();
      if (photoValue && videoValue) {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ["csv"]);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
    else {
      bool storageValue = await storagePermission();
      bool cameraValue = await cameraPermission();
      if (cameraValue && storageValue) {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ["csv"]);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
  }
  else if (Platform.isIOS){
    bool storageValue = await storagePermission();
    bool cameraValue = await cameraPermission();
    if (cameraValue && storageValue) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ["csv"]);
      if (result != null) {
        return result;
      }
    } else{
      showToast(isError: true,message: "Permission denied",);
      await permission.openAppSettings();
    }
  }
  return null;

}

Future<FilePickerResult?> pickPdfFile() async {

  if (Platform.isAndroid) {
    int sdk = await getSdkVersion();
    debugPrint("SDK_Version :: $sdk");
    if (sdk >= 33) {
      bool photoValue = await photoPermission();
      bool videoValue = await videoPermission();

      if (photoValue && videoValue) {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ["pdf"]);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
    else {
      bool storageValue = await storagePermission();
      bool cameraValue = await cameraPermission();
      if (cameraValue && storageValue) {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ["pdf"]);
        if (result != null) {
          return result;
        }
      } else {
        showToast(isError: true,message: "Permission denied",);
        await permission.openAppSettings();
      }
    }
  }
  else if (Platform.isIOS){
    bool storageValue = await storagePermission();
    bool cameraValue = await cameraPermission();
    if (cameraValue && storageValue) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ["pdf"]);
      if (result != null) {
        return result;
      }
    } else{
      showToast(isError: true,message: "Permission denied",);
      await permission.openAppSettings();
    }
  }
  return null;

}

Future<bool> locationPermission() async{
  var status = await permission.Permission.location.status;
  switch(status){
    case permission.PermissionStatus.denied : {
      var service = await permission.Permission.location.request();
      return service.isDenied ? false : true;
    }
    case permission.PermissionStatus.granted:
      return true;
    case permission.PermissionStatus.restricted:
      showToast(isError: true,message: "Please enable location permission");
      return false;
    case permission.PermissionStatus.permanentlyDenied:
      showToast(isError: true,message: "Please enable location permission");
      permission.openAppSettings();
      return false;
    case permission.PermissionStatus.limited:
      showToast(isError: true,message: "Please enable location permission");
      return false;
    default :
      return false;
  }
}

Future<bool> storagePermission() async{
  var status = await permission.Permission.storage.status;
  switch(status){
    case permission.PermissionStatus.denied : {
      var requestValue = await permission.Permission.storage.request();
      return requestValue.isDenied ? false : true;
    }
    case permission.PermissionStatus.granted:
      return true;
    case permission.PermissionStatus.restricted:
      showToast(isError: true,message: "Please enable storage permission");
      return false;
    case permission.PermissionStatus.permanentlyDenied:
      showToast(isError: true,message: "Please enable storage permission");
      permission.openAppSettings();
      return false;
    case permission.PermissionStatus.limited:
      showToast(isError: true,message: "Please enable storage permission");
      return false;
    default :
      return false;
  }
}

Future<bool> cameraPermission() async{
  var status = await permission.Permission.camera.status;

  switch(status){
    case permission.PermissionStatus.denied : {
      var requestValue = await permission.Permission.camera.request();
      return requestValue.isDenied ? false : true;
    }
    case permission.PermissionStatus.granted:
      return true;

    case permission.PermissionStatus.restricted:
      showToast(isError: true,message: "Please enable camera permission");
      return false;
    case permission.PermissionStatus.permanentlyDenied:
      showToast(isError: true,message: "Please enable camera permission");
      permission.openAppSettings();
      return false;

    case permission.PermissionStatus.limited:
      showToast(isError: true,message: "Please enable camera permission");
      return false;

    default :
      return false;
  }
}

Future<bool> photoPermission() async{
  var status = await permission.Permission.photos.status;
  debugPrint("PhotoStatus: $status");
  switch(status){
    case permission.PermissionStatus.denied : {
      var requestValue = await permission.Permission.photos.request();
      return requestValue.isDenied ? false : true;
    }

    case permission.PermissionStatus.granted:
      return true;

    case permission.PermissionStatus.restricted:
      showToast(isError: true, message: "Please enable storage permission");

      return false;
    case permission.PermissionStatus.permanentlyDenied:
      showToast(isError: true,message: "Please enable storage permission");
      permission.openAppSettings();
      return false;

    case permission.PermissionStatus.limited:
      showToast(isError: true,message: "Please enable storage permission");
      return false;

    default :
      return false;
  }
}

Future<bool> videoPermission() async{
  var status = await permission.Permission.videos.status;
  debugPrint("VideoStatus: $status");

  switch(status){
    case permission.PermissionStatus.denied : {
      var requestValue = await permission.Permission.videos.request();
      return requestValue.isDenied ? false : true;
    }

    case permission.PermissionStatus.granted:
      return true;

    case permission.PermissionStatus.restricted:
      showToast(isError: true,message: "Please enable storage permission");

      return false;
    case permission.PermissionStatus.permanentlyDenied:
      showToast(isError: true,message: "Please enable storage permission");
      permission.openAppSettings();
      return false;

    case permission.PermissionStatus.limited:
      showToast(isError: true,message: "Please enable storage permission");
      return false;

    default :
      return false;
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    final int special = 8 + _random.nextInt(4);
    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}

Future<int> getSdkVersion() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  debugPrint('Running on ${androidInfo.id}');
  return androidInfo.version.sdkInt;
}


/// ==============================================
/// METHODS
/// ==============================================
void hideKeyboard(BuildContext context) {FocusScope.of(context).requestFocus(FocusNode()); }


void showToast({required bool isError, required String message}) async {
  DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(milliseconds: 1000),
    animationDuration: const Duration(milliseconds: 500),
    position: DelightSnackbarPosition.top,
    builder: (context) => ToastCard(
      color: Colors.white,
      leading: isError
          ? Icon(
        Icons.warning_rounded,
        color: Colors.red,
        size: MediaQuery.sizeOf(context).width * numD1,
      )
          : Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: MediaQuery.sizeOf(context).width * numD1,
      ),
      title: CommonText(
          text: message,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.sizeOf(context).width * numD035),
    ),
  ).show(navigatorKey.currentContext!);
}
void showToastLongDelay({required bool isError, required String message}) async {
  DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(milliseconds: 5000),
    animationDuration: const Duration(milliseconds: 500),
    builder: (context) => ToastCard(
      color: Colors.white,
      leading: isError
          ? Icon(
        Icons.warning_rounded,
        color: Colors.red,
        size: MediaQuery.sizeOf(context).width * numD1,
      )
          : Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: MediaQuery.sizeOf(context).width * numD1,
      ),
      title: CommonText(
          text: message,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.sizeOf(context).width * numD035),
    ),
  ).show(navigatorKey.currentContext!);
}
void showToastWithTitle({required bool isError, required String title, required String message}) async {
  DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(milliseconds: 3000),
    animationDuration: const Duration(milliseconds: 500),
    position: DelightSnackbarPosition.top,
    builder: (context) => ToastCard(
      color: Colors.white,
      leading: isError
          ? Icon(
        Icons.warning_rounded,
        color: Colors.red,
        size: MediaQuery.sizeOf(context).width * numD1,
      )
          : Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: MediaQuery.sizeOf(context).width * numD1,
      ),
      title: CommonText(
          text: title,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.sizeOf(context).width * numD04),
      subtitle: CommonText(
          text: message,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.sizeOf(context).width * numD03),
    ),
  ).show(navigatorKey.currentContext!);
}


String hideMobileNumber(String mobileNumber) {
  if (mobileNumber.length < 4) {
    return mobileNumber;
  } else {
    String maskedNumber = '*' * (mobileNumber.length - 4) +
        mobileNumber.substring(mobileNumber.length - 4);
    return maskedNumber;
  }
}
String generateAutoId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}
DateTime getNextDay(DateTime date, int day) {
  int diff = day - date.weekday;
  if (diff <= 0) diff += 7;
  return date.add(Duration(days: diff));
}
String getDaysLeft(DateTime targetDate) {

  DateTime now = DateTime.now();
  int difference = targetDate.difference(now).inDays;

  if(difference.isNegative){
    return targetDate.toString().split(" ").first;
  } else if (difference == 0) {
    return 'Today';
  } else if (difference == 1) {
    return 'Tomorrow';
  } else if (difference < 7) {
    if(difference == 1){
      return '$difference day left';
    }else{
      return '$difference days left';
    }
  } else {
    return targetDate.toString().split(" ").first;
  }
}
String timeAgo(DateTime dateTime, {bool numericDates = true}) {
  final date2 = DateTime.now();
  final difference = date2.difference(dateTime);

  if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return 'Just now';
  }
}
bool dateTimeFormatCheck(String date) {
  try {
    DateTime covertValue = DateTime.parse(date);
    return true;
  } on FormatException catch (e) {
    return false;
  }
}
String dateTimeFormatter({required String dateTime,
  String format = "yyyy-MM-dd",
  bool time = false,
  bool utc = false}) {
  try {
    debugPrint("FormatTime: $dateTime");
    DateTime currentDateTime =
    utc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    DateTime parseDateTime = DateTime.now();

    if (dateTimeFormatCheck(dateTime) && format.isNotEmpty) {
      parseDateTime = DateTime.parse(dateTime);
    } else if (time) {
      String date = DateFormat('yyyy-MM-dd').format(currentDateTime);
      parseDateTime = DateTime.parse("$date $dateTime");
    } else {
      String time = DateFormat('HH:mm:ss').format(currentDateTime);
      parseDateTime = DateTime.parse("$dateTime $time");
    }

    return DateFormat(format)
        .format(utc ? parseDateTime.toUtc() : parseDateTime.toLocal());
  } on FormatException catch (e) {
    return DateFormat(format).format(DateTime.now());
  }
}
int weekdayFromString(String day) {
  switch (day.toLowerCase()) {
    case 'mon':
      return DateTime.monday;
    case 'tue':
      return DateTime.tuesday;
    case 'wed':
      return DateTime.wednesday;
    case 'thu':
      return DateTime.thursday;
    case 'fri':
      return DateTime.friday;
    case 'sat':
      return DateTime.saturday;
    case 'sun':
      return DateTime.sunday;
    default:
      return -1;
  }
}
int getTimeDifferenceInDays(String date){
  DateTime startDate = DateTime.parse(date);
  DateTime endDate = DateTime.now(); // Current date
  Duration difference = startDate.difference(endDate);
  int differenceInDays = difference.inDays;

  return differenceInDays;
}


extension Currency on double {
  String indianRupeeFormat() {
    return NumberFormat.currency(locale: 'en_IN', symbol: '₹ ',decimalDigits: 0).format(this);
  }
}


extension StringExtenstions on String {
  String toCapitalize() {
    if (isEmpty) {
      return this;
    } else {
      return this[0].toUpperCase() + substring(1);
    }
  }

  /// check whether the string is valid email or not

  bool isValidEmail() =>
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(this);

  ///return true if there is only alphabets in string
  bool isAlpha() => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  ///return true if there is only alphabets and numeric (no special chars $%^&*)
  bool isAlphaNumeric() => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  ///return true if there is only numeric values in string eg 12345 or 1.22
  bool isNumeric() => RegExp(r'^-?[0-9]+$').hasMatch(this);

  ///return true if string is valid integer eg 123
  bool isInt() => RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$').hasMatch(this);

  ///return true if string is valid floating value eg 1.2
  bool isFloat() =>
      RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$')
          .hasMatch(this);

  ///return true if string is valid hexadecimal color code
  bool isHexColor() =>
      RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$').hasMatch(this);

  //Conversion function

  ///parse string to Int
  int toInt() => int.parse(this);

  ///parse string to Double
  double toDouble() => double.parse(this);

  ///parse string hexadecimal color to color object
  Color toHexColor() =>
      Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);


  ///parse string to JsonMap
  Map<String, dynamic> toJsonMap() => jsonDecode(this);

  ///String revers
  String revers() => String.fromCharCodes(runes.toList().reversed);

  ///parse String to DateTime
  DateTime toDate({required String format}) => DateFormat(format).parse(this);

  ///format StringDate UTC StringDate
  String formatDateStringToUTC(
      {required String? inputPattern, required String? outputPattern}) {
    if (outputPattern == null || outputPattern.isEmpty) {
      outputPattern = inputPattern;
    }
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(this).toUtc());
  }

  ///changes the date format
  String changeDateStringFormat(
      {required String inputPattern, required String outputPattern}) {
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(this));
  }

  ///parse StringDate toLocal date
  String formatDateStringToLocal(
      {required String? inputPattern, required String? outputPattern}) {
    if (outputPattern == null || outputPattern.isEmpty) {
      outputPattern = inputPattern;
    }
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(this).toLocal());
  }

  ///convert String to list of Chars
  List<String> toCharsList() {
    List<String> arr = [];
    for (var rune in runes) {
      arr.add(String.fromCharCode(rune));
    }
    return arr;
  }

  ///divide String to ListString
  List<String> chunks(int sizeOfChunks) {
    List<String> chunks = [];
    List charList = toCharsList();
    int len = charList.length;
    for (var i = 0; i < len; i += sizeOfChunks) {
      int size = i + sizeOfChunks;
      chunks.add((charList.sublist(i, size > len ? len : size)).join());
    }
    return chunks;
  }

  ///replace chars from start to end with  eg 12345****10
  String replaceChars(
      {int start = 0, required int end, String delimiter = "*"}) {
    StringBuffer buffer = StringBuffer();
    int counter = 0;
    for (var rune in runes) {
      if (counter >= start && counter <= end) {
        buffer.write(delimiter);
      } else {
        buffer.write(String.fromCharCode(rune));
      }
      counter++;
    }
    return buffer.toString();
  }

  ///insert string in after specify chars[steps]
  String insert({required int steps, required String valueToInsert}) {
    StringBuffer buffer = StringBuffer();
    int counter = 0;
    for (var rune in runes) {
      if (counter == steps) {
        buffer.write(valueToInsert);
        counter = 0;
      }
      buffer.write(String.fromCharCode(rune));
      counter++;
    }
    return buffer.toString();
  }

  ///compare string in case Insensitive manner
  bool equalsIgnoreCase(String compareTo) =>
      toLowerCase() == compareTo.toLowerCase();
}

String formatTime(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
  return "$minutes:$remainingSeconds";
}


