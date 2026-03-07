import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:free_style/network_class/web_urls.dart';
import '../../main.dart';
import '../utils/common_constants.dart';
import 'network_response.dart';

class DioNetworkClass {
  static const int _defaultTimeoutSeconds = 90;
  static const int _successStatusCodeThreshold = 201;

  final Dio _dio = Dio();
  final String endUrl;
  final NetworkResponse? networkResponse;
  final int requestCode;
  final Map<String, dynamic> jsonBody;
  final List<dynamic> imageArray;
  final String filePath;
  final String param;

  AlertDialog? _alertDialog;
  bool _isShowingDialog = false;

  /// ValueNotifier for progress
  final ValueNotifier<double> uploadProgressNotifier = ValueNotifier(0.0);

  DioNetworkClass({
    required this.endUrl,
    required this.networkResponse,
    required this.requestCode,
    this.jsonBody = const {},
    this.imageArray = const [],
    this.filePath = "",
    this.param = "",
  });

  DioNetworkClass.get({
    required this.endUrl,
    required this.networkResponse,
    required this.requestCode,
    this.jsonBody = const {},
  })  : imageArray = const [],
        filePath = "",
        param = "";

  DioNetworkClass.post({
    required this.endUrl,
    required this.networkResponse,
    required this.requestCode,
    this.jsonBody = const {},
  })  : imageArray = const [],
        filePath = "",
        param = "";

  DioNetworkClass.upload({
    required this.endUrl,
    required this.networkResponse,
    required this.requestCode,
    this.jsonBody = const {},
    this.filePath = "",
    this.imageArray = const [],
    required this.param,
  });

  Future<void> callRequest({
    required String requestType,
    bool showLoader = false,
    bool isMultipart = false,
  }) async {
    try {
      if (showLoader) {
        await _showLoaderDialog(navigatorKey.currentContext!);
      }

      final options = Options(
        method: requestType.toUpperCase(),
        headers: await _getHeaders(),
        sendTimeout: const Duration(seconds: _defaultTimeoutSeconds),
      );

      _configureDioDefaults();
      _logRequestDetails(requestType);

      final requestData = isMultipart
          ? await _prepareMultipartData()
          : (requestType.toLowerCase() == 'get' ? null : jsonBody);

      final response = await _dio.request(
        baseURL + endUrl,
        data: requestData,
        options: options,
        queryParameters: requestType.toLowerCase() == 'get' && jsonBody.isNotEmpty
            ? jsonBody
            : null,
        onSendProgress: (sent, total) {
          _onSendProgress(sent, total);
        },
      );

      await _handleResponse(response);
    } on DioException catch (e) {
      await _handleDioError(e);
    } catch (err) {
      await _handleGenericError(err);
    } finally {
      if (showLoader && _isShowingDialog) {
        await _hideLoaderDialog();
      }
    }
  }

  Future<Map<String, String>?> _getHeaders() async {
    final token = sharedPreferences.getString(PreferenceKeys.tokenKey);
    if (token != null) {
      debugPrint("Request Token: $token");
      return {headerKey: token};
    }
    return null;
  }

  void _configureDioDefaults() {
    _dio.options.connectTimeout = const Duration(seconds: _defaultTimeoutSeconds);
    _dio.options.receiveTimeout = const Duration(seconds: _defaultTimeoutSeconds);
    _dio.options.contentType = Headers.jsonContentType;
  }

  void _logRequestDetails(String requestType) {
    log("""
    Request Details:
    Type: $requestType
    URL: ${baseURL + endUrl}
    ${requestType.toLowerCase() == 'get' && jsonBody.isNotEmpty
        ? 'Query Parameters: $jsonBody'
        : 'Body: $jsonBody'}
    """);

    if (filePath.isNotEmpty) {
      debugPrint("File Path: $filePath");
    }
    if (imageArray.isNotEmpty) {
      debugPrint("Image Array: $imageArray");
    }
  }

  Future<FormData> _prepareMultipartData() async {
    final formData = FormData.fromMap(jsonBody);

    if (imageArray.isNotEmpty) {
      for (final imagePath in imageArray) {
        formData.files.add(
          MapEntry(
            param,
            await MultipartFile.fromFile(imagePath),
          ),
        );
      }
    } else if (filePath.isNotEmpty) {
      formData.files.add(
        MapEntry(
          param,
          await MultipartFile.fromFile(filePath),
        ),
      );
    }

    return formData;
  }

  Future<void> _handleResponse(Response response) async {
    debugPrint("Response Code: ${response.statusCode}");
    debugPrint("Response Data: ${response.data}");

    if (response.statusCode != null &&
        response.statusCode! <= _successStatusCodeThreshold) {
      networkResponse?.onResponse(
        requestCode: requestCode,
        response: jsonEncode(response.data),
      );
    } else {
      networkResponse?.onApiError(
        requestCode: requestCode,
        response: jsonEncode(response.data),
      );
    }
  }

  Future<void> _handleDioError(DioException e) async {
    log("""
    Dio Error:
    Type: ${e.type}
    Message: ${e.message}
    Response: ${e.response?.data}
    """);

    if (e.response?.data.toString().toLowerCase() == "unauthorized") {
      _handleUnauthorizedError();
    }

    if (e.error is SocketException) {
      _handleSocketException(e.error as SocketException);
    } else if (e.type == DioExceptionType.badResponse && e.response != null) {
      networkResponse?.onApiError(
        requestCode: requestCode,
        response: jsonEncode(e.response!.data),
      );
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      _showTimeoutError();
    }
  }

  void _handleUnauthorizedError() {
    debugPrint("::::UNAUTHORIZED::::");
  }

  void _handleSocketException(SocketException e) {
    final errorCode = e.osError?.errorCode ?? 0;
    final errorMessage = e.osError?.message ?? "Unknown socket error";

    switch (errorCode) {
      case 7:
      case 8:
        _showNetworkError("Internet Connection Error");
        break;
      case 111:
        _showNetworkError("Unable to connect to Server");
        break;
      default:
        _showNetworkError("Unknown Error: $errorMessage");
    }
  }

  void _showNetworkError(String message) {
    // Show network error
  }

  void _showTimeoutError() {
    // Show timeout error
  }

  Future<void> _handleGenericError(dynamic err) async {
    debugPrint('Generic Error: $err');
    if (_isShowingDialog) {
      await _hideLoaderDialog();
    }
  }

  Future<void> _showLoaderDialog(BuildContext context) async {
    if (_isShowingDialog) return;

    _isShowingDialog = true;
    _alertDialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0),
      content: Center(
        child: CircularProgressIndicator(
          color: CommonColors.secondaryColor,
        ),
      ),
    );

    await showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: _alertDialog!,
        );
      },
    );
  }

  Future<void> _hideLoaderDialog() async {
    if (!_isShowingDialog || navigatorKey.currentState == null) return;

    _isShowingDialog = false;
    Navigator.of(navigatorKey.currentState!.context, rootNavigator: true).pop();
  }

  void _onSendProgress(int sent, int total) {
    if (total <= 0) return;
    uploadProgressNotifier.value = sent / total;
    debugPrint("Upload Progress: ${(uploadProgressNotifier.value * 100).toStringAsFixed(2)}%");
  }
}



/*Widget downloadUsage(BuildContext context) {
  return Column(
    children: [
      ElevatedButton(
        onPressed: () {
          dioClass.callRequest(
            requestType: "POST",
            isMultipart: true,
            showLoader: true,
          );
        },
        child: Text("Upload"),
      ),
      SizedBox(height: 20),
      ValueListenableBuilder<double>(
        valueListenable: dioClass.uploadProgressNotifier,
        builder: (context, progress, child) {
          return LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          );
        },
      ),
    ],
  );
}*/
