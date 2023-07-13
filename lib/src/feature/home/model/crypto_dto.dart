// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_dto.freezed.dart';
part 'crypto_dto.g.dart';

@freezed
class CryptoData with _$CryptoData {
  const factory CryptoData({
    @JsonKey(name: 'T') String? name,
    @JsonKey(name: 'o') required double open,
    @JsonKey(name: 'c') required double close,
    @JsonKey(name: 'h') required double high,
    @JsonKey(name: 'l') required double low,
    @JsonKey(name: 't') required int time,
  }) = _CryptoData;

  factory CryptoData.fromJson(Map<String, dynamic> json) => _$CryptoDataFromJson(json);
}
