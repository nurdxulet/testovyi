// ignore_for_file: avoid-dynamic

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testovyi/src/core/network/interfaces/base_client_generator.dart';

part 'home_api.freezed.dart';

@freezed
class HomeApi extends BaseClientGenerator with _$HomeApi {
  const HomeApi._() : super();

  /// Запрос для получения списка криптовалют
  const factory HomeApi.groupedDaily(String date, String apiKey) = _FriendsExist;

  /// Запрос для получения списка криптовалют
  const factory HomeApi.aggregates(String cryptoTicker, String multiplier, String timespan, String dateFrom,
      String dateTo, String sort, int limit, String apiKey) = _Aggregates;

  /// Здесь описываются body для всех запросов
  /// По умолчанию null
  @override
  dynamic get body => whenOrNull();

  /// Используемые методы запросов, по умолчанию 'GET'
  @override
  String get method => maybeWhen(
        orElse: () => 'GET',
      );

  /// Пути всех запросов (после [kBaseUrl])
  @override
  String get path => when(
        aggregates: (cryptoTicker, multiplier, timespan, dateFrom, dateTo, sort, limit, apiKey) =>
            '/v2/aggs/ticker/$cryptoTicker/range/$multiplier/$timespan/$dateFrom/$dateTo',
        groupedDaily: (date, apiKey) => '/v2/aggs/grouped/locale/global/market/crypto/$date',
      );

  /// Параметры запросов
  @override
  Map<String, dynamic>? get queryParameters => whenOrNull(
        groupedDaily: (date, apiKey) => {
          'apiKey': apiKey,
          'adjusted': 'true',
        },
        aggregates: (cryptoTicker, multiplier, timespan, dateFrom, dateTo, sort, limit, apiKey) => {
          'cryptoTicker': cryptoTicker,
          'multiplier': multiplier,
          'apiKey': apiKey,
          'adjusted': 'true',
        },
      );
}
