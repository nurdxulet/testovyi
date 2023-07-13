import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';
import 'package:testovyi/src/feature/home/repository/home_repository.dart';

part 'aggregates_cubit.freezed.dart';

const _tag = 'DailyBarsCubit';

class AggregatesCubit extends Cubit<AggregatesState> {
  final IHomeRepository _repository;

  AggregatesCubit(this._repository) : super(const AggregatesState.initialState());

  Future<void> getAggregates(String cryptoTicker, String multiplier, String timespan, String dateFrom, String dateTo,
      String sort, int limit, String apiKey) async {
    emit(const AggregatesState.loadingState());

    final result =
        await _repository.getAggregates(cryptoTicker, multiplier, timespan, dateFrom, dateTo, sort, limit, apiKey);

    result.when(
      success: (barList) {
        emit(AggregatesState.loadedState(barList: barList));
      },
      failure: (error) => emit(
        AggregatesState.errorState(
          message: error.msg ?? "Ошибка при получении списка DAILY BARS",
        ),
      ),
    );
  }
}

@freezed
class AggregatesState with _$AggregatesState {
  const factory AggregatesState.initialState() = _InitialState;

  const factory AggregatesState.loadingState() = _LoadingState;

  const factory AggregatesState.loadedState({
    required List<CryptoData> barList,
  }) = _LoadedState;

  const factory AggregatesState.errorState({
    required String message,
  }) = _ErrorState;
}
