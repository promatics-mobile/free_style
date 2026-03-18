import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../main.dart';
import '../utils/common_constants.dart';
import '../utils/common_methods.dart';
import 'api_loader.dart';
import 'internet_service.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  /// Queue for pending requests
  final List<QueuedRequest> _pendingRequests = [];

  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 90),
        receiveTimeout: const Duration(seconds: 90),
        contentType: Headers.jsonContentType,
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    /// Listen for internet restore
    InternetConnection().onStatusChange.listen((status) async {
      if (status == InternetStatus.connected && _pendingRequests.isNotEmpty) {
        debugPrint("🌐 Internet back → Retrying queued APIs");

        final requests = List<QueuedRequest>.from(_pendingRequests);
        _pendingRequests.clear();

        for (var queued in requests) {
          try {
            final response = await dio.fetch(queued.requestOptions);
            queued.completer.complete(response);
          } catch (e) {
            queued.completer.completeError(e);
          }
        }
      }
    });

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          /// Check internet
          bool hasInternet = await InternetService.hasInternet();

          if (!hasInternet) {
            showToast(isError: true, message: "No internet connection");
            final completer = Completer<Response>();

            /// Prevent duplicate queue
            bool alreadyQueued = _pendingRequests.any(
              (r) =>
                  r.requestOptions.uri == options.uri && r.requestOptions.method == options.method,
            );

            if (!alreadyQueued) {
              /// Queue limit protection
              if (_pendingRequests.length > 10) {
                _pendingRequests.removeAt(0);
              }
              _pendingRequests.add(QueuedRequest(requestOptions: options, completer: completer));
            }

            /// Hide loader
            ApiLoader.hide();
            debugPrint("📦 Queueing request: ${options.uri} → ${_pendingRequests.length}");

            /// Still return future so API structure remains same
            final response = await completer.future;
            return handler.resolve(response);
          }

          /// Add Token
          final token = sharedPreferences.getString(PreferenceKeys.tokenKey);

          if (token != null && token.isNotEmpty) {
            options.headers[headerKey] = "Bearer $token";
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

              final delay = Duration(seconds: retryCount * 2);

              debugPrint("🔁 Retrying API ($retryCount/3) after ${delay.inSeconds}s");

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

class QueuedRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;

  QueuedRequest({required this.requestOptions, required this.completer});
}
