import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/network_class/api_loader.dart';

import '../utils/common_methods.dart';
import 'api_response.dart';
import 'dio_client.dart';

class DioNetworkCall {
  final Dio _dio = DioClient().dio;

  Future<void> callApiRequest({
    required String endUrl,
    required String method,
    required int requestCode,
    required NetworkResponse networkResponse,

    Map<String, dynamic>? json,
    Map<String, dynamic>? query,

    File? file,
    List<File>? files,
    String fileKey = "file",

    bool showLoader = false,
    Function(double progress)? onProgress,
  }) async {
    try {
      if (showLoader) {
        ApiLoader.show();
      }

      dynamic requestData = json;

      /// Multipart support
      if (file != null || (files != null && files.isNotEmpty)) {
        final formMap = Map<String, dynamic>.from(json ?? {});

        if (file != null) {
          formMap[fileKey] = await MultipartFile.fromFile(file.path);
        }

        if (files != null && files.isNotEmpty) {
          formMap[fileKey] = await Future.wait(files.map((f) => MultipartFile.fromFile(f.path)));
        }

        requestData = FormData.fromMap(formMap);
      }

      final response = await _dio.request(
        endUrl,
        data: requestData,
        queryParameters: query,
        options: Options(method: method),
        onSendProgress: (sent, total) {
          if (onProgress != null && total != 0) {
            onProgress(sent / total);
          }
        },
      );

      if (showLoader) {
        ApiLoader.hide();
      }

      /// Success 200 OR 201
      if (response.statusCode! <= 201) {
        /// Logging Response
        debugPrint("✅ CODE → ${response.statusCode}");
        debugPrint("✅ RESPONSE → ${jsonEncode(response.data)}");

        try {
          networkResponse.onResponse(
            requestCode: requestCode,
            response: jsonEncode(response.data as Map<String, dynamic>),
          );
        } catch (e, stack) {
          debugPrint("❌ onResponse ERROR → $e");
          debugPrint(stack.toString());
        }
      } else {
        /// Logging Response
        debugPrint("❌ ERROR CODE → ${response.statusCode}");
        debugPrint("❌ ERROR RESPONSE → ${jsonEncode(response.data)}");

        var data = response.data as Map<String, dynamic>;
        if(!data.toString().contains("Username already taken")){
          showToast(isError: true, message: data['message'].toString());
        }

        try {
          networkResponse.onApiError(
            requestCode: requestCode,
            response: jsonEncode(response.data as Map<String, dynamic>),
          );
        } catch (e, stack) {
          debugPrint("❌ onApiError → $e");
          debugPrint(stack.toString());
        }
      }
    } on DioException catch (e) {
      try {
        networkResponse.onApiError(requestCode: requestCode, response: jsonEncode(_handleError(e)));
      } catch (e, stack) {
        debugPrint("❌ onApiError → $e");
        debugPrint(stack.toString());
      }
    } catch (e) {
      try {
        networkResponse.onApiError(
          requestCode: requestCode,
          response: jsonEncode({"message": e.toString()}),
        );
      } catch (e, stack) {
        debugPrint("❌ onApiError → $e");
        debugPrint(stack.toString());
      }
    } finally {
      if (showLoader) {
        ApiLoader.hide();
      }
    }
  }

  Map<String, dynamic> _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return {"message": "Connection Timeout"};

      case DioExceptionType.receiveTimeout:
        return {"message": "Server Timeout"};

      case DioExceptionType.badResponse:
        return {"message": e.response?.data.toString() ?? "Server Error"};

      case DioExceptionType.connectionError:
        return {"message": "No Internet Connection"};

      default:
        return {"message": "Something went wrong"};
    }
  }
}
