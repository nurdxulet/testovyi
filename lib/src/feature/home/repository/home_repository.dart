import 'package:testovyi/src/core/network/result.dart';
import 'package:testovyi/src/feature/home/datasource/home_remote_ds.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';

abstract class IHomeRepository {
  Future<Result<List<CryptoData>>> getDailyBars(String date, String apiKey);
  Future<Result<List<CryptoData>>> getAggregates(String cryptoTicker, String multiplier, String timespan,
      String dateFrom, String dateTo, String sort, int limit, String apiKey);
}

class HomeRepositoryImpl extends IHomeRepository {
  final IHomeRemoteDS _remoteDS;

  HomeRepositoryImpl({
    required IHomeRemoteDS remoteDS,
  }) : _remoteDS = remoteDS;

  @override
  Future<Result<List<CryptoData>>> getDailyBars(String date, String apiKey) async =>
      _remoteDS.getDailyBars(date, apiKey);

  @override
  Future<Result<List<CryptoData>>> getAggregates(String cryptoTicker, String multiplier, String timespan,
          String dateFrom, String dateTo, String sort, int limit, String apiKey) =>
      _remoteDS.getAggregates(cryptoTicker, multiplier, timespan, dateFrom, dateTo, sort, limit, apiKey);
}
