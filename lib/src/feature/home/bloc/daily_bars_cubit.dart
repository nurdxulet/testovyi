import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';
import 'package:testovyi/src/feature/home/repository/home_repository.dart';

part 'daily_bars_cubit.freezed.dart';

const _tag = 'DailyBarsCubit';

class DailyBarsCubit extends Cubit<DailyBarsState> {
  final IHomeRepository _repository;

  DailyBarsCubit(this._repository) : super(const DailyBarsState.initialState());

  Future<void> getDailyBars(String date, String apiKey) async {
    emit(const DailyBarsState.loadingState());

    final result = await _repository.getDailyBars(date, apiKey);

    result.when(
      success: (barList) {
        emit(DailyBarsState.loadedState(barList: barList));
      },
      failure: (error) => emit(
        DailyBarsState.errorState(
          message: error.msg ?? "Ошибка при получении списка DAILY BARS",
        ),
      ),
    );
  }
}

@freezed
class DailyBarsState with _$DailyBarsState {
  const factory DailyBarsState.initialState() = _InitialState;

  const factory DailyBarsState.loadingState() = _LoadingState;

  const factory DailyBarsState.loadedState({
    required List<CryptoData> barList,
  }) = _LoadedState;

  const factory DailyBarsState.errorState({
    required String message,
  }) = _ErrorState;
}
