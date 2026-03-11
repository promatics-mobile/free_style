import 'dart:async';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final int retryDelay;

  RetryInterceptor({
    required this.dio,
    this.retries = 3,
    this.retryDelay = 2,
  });

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {

    if (_shouldRetry(err)) {

      final attempt = err.requestOptions.extra["retry_attempt"] ?? 0;

      if (attempt < retries) {

        err.requestOptions.extra["retry_attempt"] = attempt + 1;

        await Future.delayed(Duration(seconds: retryDelay));

        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }

    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout
        || err.type == DioExceptionType.receiveTimeout
        || err.type == DioExceptionType.connectionError
        || err.type == DioExceptionType.badResponse;
  }
}