// ignore_for_file: avoid-non-null-assertion

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:testovyi/src/core/network/interfaces/base_client_generator.dart';
import 'package:testovyi/src/core/network/network_options/network_options.dart';

class NetworkCreator {
  /// Call `fetch` with given options
  Future<Response> request({
    required BaseClientGenerator route,
    required Dio dio,
    NetworkOptions? options,
  }) =>
      dio.fetch(
        RequestOptions(
          headers: dio.options.headers,
          baseUrl: dio.options.baseUrl,
          method: route.method,
          path: route.path,
          queryParameters: route.queryParameters,
          data: route.body,
          sendTimeout: Duration(milliseconds: route.sendTimeout ?? 20000),
          receiveTimeout: Duration(milliseconds: route.receiveTimeOut ?? 20000),
          onReceiveProgress: options?.onReceiveProgress,
          onSendProgress: options?.onSendProgress,
          validateStatus: (statusCode) => statusCode! >= HttpStatus.ok && statusCode <= HttpStatus.multipleChoices,
        ),
      );
}
