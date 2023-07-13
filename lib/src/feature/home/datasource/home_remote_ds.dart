import 'package:flutter/foundation.dart';
import 'package:l/l.dart';
import 'package:testovyi/src/core/error/network_exception.dart';
import 'package:testovyi/src/core/network/layers/network_executer.dart';
import 'package:testovyi/src/core/network/result.dart';
import 'package:testovyi/src/core/utils/error_util.dart';
import 'package:testovyi/src/feature/home/datasource/home_api.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';

abstract class IHomeRemoteDS {
  Future<Result<List<CryptoData>>> getDailyBars(String date, String apiKey);
  Future<Result<List<CryptoData>>> getAggregates(String cryptoTicker, String multiplier, String timespan,
      String dateFrom, String dateTo, String sort, int limit, String apiKey);
}

class HomeRemoteDSImpl implements IHomeRemoteDS {
  final NetworkExecuter client;

  HomeRemoteDSImpl({
    required this.client,
  });

  Future<Result<T>> _catchError<T>(String label, Object e, StackTrace stackTrace) async {
    if (kDebugMode) {
      l.d('$label => ${NetworkException.type(error: e.toString())}');

      await ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '$label => ${NetworkException.type(error: e.toString())}',
      );
    }

    return Result<T>.failure(
      NetworkException.type(error: e.toString()),
    );
  }

  @override
  Future<Result<List<CryptoData>>> getDailyBars(String date, String apiKey) async {
    try {
      final Result<Map?> result = await client.produce(
        route: HomeApi.groupedDaily(date, apiKey),
      );

      return result.when(
        success: (Map? response) async {
          try {
            if (response == null) {
              return const Result.failure(NetworkException.type(error: 'Incorrect data parsing!'));
            }
            final List<CryptoData> list = await compute<List, List<CryptoData>>(
              (List list) {
                return list.map((e) => CryptoData.fromJson(e as Map<String, dynamic>)).toList();
              },
              response['results'] ?? [],
            );
            return Result.success(list);
          } on Object catch (e, stackTrace) {
            return _catchError('getDailyBars', e, stackTrace);
          }
        },
        failure: (NetworkException exception) => Result<List<CryptoData>>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('getDailyBars => ${NetworkException.type(error: e.toString())}');
      }
      return Result<List<CryptoData>>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<CryptoData>>> getAggregates(String cryptoTicker, String multiplier, String timespan,
      String dateFrom, String dateTo, String sort, int limit, String apiKey) async {
    try {
      final Result<Map?> result = await client.produce(
        route: HomeApi.aggregates(cryptoTicker, multiplier, timespan, dateFrom, dateTo, sort, limit, apiKey),
      );

      return result.when(
        success: (Map? response) async {
          try {
            if (response == null) {
              return const Result.failure(NetworkException.type(error: 'Incorrect data parsing!'));
            }
            final List<CryptoData> list = await compute<List, List<CryptoData>>(
              (List list) {
                return list.map((e) => CryptoData.fromJson(e as Map<String, dynamic>)).toList();
              },
              response['results'] ?? [],
            );
            return Result.success(list);
          } on Object catch (e, stackTrace) {
            return _catchError('getAggregates', e, stackTrace);
          }
        },
        failure: (NetworkException exception) => Result<List<CryptoData>>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('getAggregates => ${NetworkException.type(error: e.toString())}');
      }
      return Result<List<CryptoData>>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }
}
