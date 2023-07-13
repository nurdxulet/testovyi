import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkException with _$NetworkException implements Exception {
  const NetworkException._() : super();

  /// Вызывается если случился [DioException]
  const factory NetworkException.request({required DioException error}) = _ResponseError;

  /// Вызывается при общих ошибках
  const factory NetworkException.type({String? error}) = _DecodingError;

  /// Вызывается если нету доступа в интернет
  const factory NetworkException.connectivity({@Default('No internet access!') String message}) = _Connectivity;

  /// Вызывается при тайм ауте запроса
  const factory NetworkException.timeOut({@Default('The request time has expired!') String message}) = _TimeOut;

  /// Сообщение ошибки
  String? get msg => when<String?>(
        type: (String? error) => error,
        connectivity: (String message) => message,
        timeOut: (String message) => message,
        request: _parseDioError,
      );

  /// Возвращаем тексты в зависимости от статус кода
  String _parseDioError(DioException error) {
    switch (error.response?.statusCode) {
      case HttpStatus.unauthorized:
        return 'Not authorized. Please log in again!';
      case HttpStatus.notFound:
        return 'The content you are looking for has not been found!';
      case HttpStatus.internalServerError:
        return 'Something is wrong with our servers, the problem will be solved soon!';
      default:
        return (error.response?.data as Map<String, dynamic>)['message'] as String;
    }
  }
}
