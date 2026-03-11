import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/network_class/web_urls.dart';

import '../main.dart';
import '../utils/common_constants.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        connectTimeout: const Duration(seconds: 90),
        receiveTimeout: const Duration(seconds: 90),
        contentType: Headers.jsonContentType,
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          /// Add Token
          final token = sharedPreferences.getString(PreferenceKeys.tokenKey);
          if (token != null && token.isNotEmpty) {
            options.headers[headerKey] = token;
          }

          /// Logging Request
          debugPrint("✅ REQUEST → ${options.method} ${options.uri}");
          debugPrint("✅ HEADERS → ${options.headers}");
          debugPrint("✅ BODY → ${options.data}");

          handler.next(options);
        },

        onResponse: (response, handler) {
          handler.next(response);
        },

        onError: (error, handler) async {
          debugPrint("❌ ERROR → ${error.message}");
          /// Retry Logic
          if (_shouldRetry(error)) {
            final options = error.requestOptions;

            int retryCount = options.extra["retry_count"] ?? 0;

            if (retryCount < 3) {
              retryCount++;

              options.extra["retry_count"] = retryCount;

              /// Exponential delay
              final delay = Duration(seconds: retryCount * 2);

              debugPrint(
                "🔁 Retrying API ($retryCount/3) after ${delay.inSeconds}s",
              );

              await Future.delayed(delay);

              try {
                final response = await dio.fetch(options);
                return handler.resolve(response);
              } catch (e) {
                return handler.next(error);
              }
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  /// Decide when retry should happen
  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.cancel) {
      return false;
    }

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    if (err.response != null) {
      final statusCode = err.response?.statusCode ?? 0;

      if (statusCode >= 500 && statusCode < 600) {
        return true;
      }
    }

    return false;
  }
}
