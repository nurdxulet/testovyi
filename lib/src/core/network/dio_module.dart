// ignore_for_file: avoid_classes_with_only_static_members, avoid_redundant_argument_values, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:testovyi/src/core/enum/environment.dart';

/// Creates new `Dio` instance
@sealed
class DioModule {
  DioModule._();

  /// Конфигурация Dio
  static Dio configureDio({
    required PackageInfo packageInfo,
  }) {
    final dio = Dio();
    dio
      ..options.baseUrl = kBaseUrl
      ..options.headers.addAll({
        'accept': 'application/json',
        'version': packageInfo.version,
        'lang': 'en',
      })
      ..interceptors.addAll([
        _AuthDioInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: true,
          compact: false,
        ),
      ]);

    return dio;
  }
}

class _AuthDioInterceptor extends Interceptor {
  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // sl<NotAuthLogic>().statusSubject.add(err.response?.statusCode ?? 0);
    if ((err.response?.statusCode ?? 0) == HttpStatus.unauthorized) {
      // sl<NotAuthLogic>().statusSubject.add(401);
    } else if ((err.response?.statusCode ?? 0) == HttpStatus.unprocessableEntity) {
    } else if ((err.response?.statusCode ?? 0) == HttpStatus.notFound) {}
    return super.onError(err, handler);
  }
}
