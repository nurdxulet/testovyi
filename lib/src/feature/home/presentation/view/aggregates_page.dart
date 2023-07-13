import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testovyi/src/core/enum/environment.dart';
import 'package:testovyi/src/core/extension/src/build_context.dart';
import 'package:testovyi/src/core/resources/resources.dart';
import 'package:testovyi/src/core/widget/custom/custom_snackbars.dart';
import 'package:testovyi/src/feature/home/bloc/aggregates_cubit.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';
import 'package:intl/intl.dart';
import 'package:testovyi/src/feature/home/presentation/widgets/time_period_widget.dart';

class AggregatesPage extends StatefulWidget with AutoRouteWrapper {
  final CryptoData crypto;
  const AggregatesPage({super.key, required this.crypto});

  @override
  _AggregatesPageState createState() => _AggregatesPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AggregatesCubit(context.repository.homeRepository),
      child: this,
    );
  }
}

class _AggregatesPageState extends State<AggregatesPage> {
  final String dateFrom = DateFormat('yyyy-MM-dd').format(DateTime(2023, 01, 09));
  final String dateTo = DateFormat('yyyy-MM-dd').format(DateTime(2023, 02, 09));
  TextEditingController textFieldController = TextEditingController();

  RefreshController refreshController = RefreshController();

  Period? selectedPeriod;
  final List<Period> periods = [
    Period('1Д', const Duration(days: 1), 'hour'),
    Period('5Д', const Duration(days: 5), 'hour'),
    Period('1Н', const Duration(days: 7), 'hour'),
    Period('1МЕС', const Duration(days: 30), 'day'),
    Period('3МЕС', const Duration(days: 90), 'day'),
  ];

  @override
  void initState() {
    _chartData = getChartData();
    selectedPeriod = periods.first;
    BlocProvider.of<AggregatesCubit>(context).getAggregates(
        widget.crypto.name ?? '', '1', selectedPeriod?.timespan ?? 'day', dateFrom, dateTo, 'asc', 5000, kApiKey);
    super.initState();
  }

  final String selectedTimespan = 'hour';

  late List<SalesData> _chartData;

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0).copyWith(bottom: 16, left: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    splashRadius: 22,
                    onPressed: () => context.router.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.crypto.name ?? '',
                      style: AppTextStyles.s26w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<AggregatesCubit, AggregatesState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () => const SizedBox(),
                    errorState: (message) => buildErrorCustomSnackBar(context, message),
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    loadingState: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loadedState: (barList) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0).copyWith(bottom: 12, top: 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Цена:',
                                  style: AppTextStyles.s14w400Grey,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.crypto.close.toString(),
                                    style: AppTextStyles.s26w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 8,
                            width: double.infinity,
                            color: AppColors.kGrey,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: SizedBox(
                              height: 17,
                              width: double.infinity,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: periods.length,
                                itemBuilder: (context, index) {
                                  return TimePeriodWidget(
                                    period: periods[index].periodName,
                                    onTap: () {
                                      selectedPeriod = periods[index];
                                      BlocProvider.of<AggregatesCubit>(context).getAggregates(
                                          widget.crypto.name ?? '',
                                          '1',
                                          selectedPeriod?.timespan ?? 'day',
                                          dateFrom,
                                          dateTo,
                                          'asc',
                                          5000,
                                          kApiKey);
                                      setState(() {});
                                    },
                                    isSelected: selectedPeriod == periods[index],
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(width: 17);
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 8,
                            width: double.infinity,
                            color: AppColors.kGrey,
                          ),
                          SfCartesianChart(
                            series: <LineSeries>[
                              LineSeries<CryptoData, DateTime>(
                                dataSource: barList,
                                xValueMapper: (CryptoData data, _) => DateTime.fromMillisecondsSinceEpoch(data.time),
                                yValueMapper: (CryptoData data, _) => data.close,
                              ),
                            ],
                          ),
                          Container(
                            height: 8,
                            width: double.infinity,
                            color: AppColors.kGrey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'HIGH:',
                                          style: AppTextStyles.s14w400Grey,
                                        ),
                                        Text(
                                          barList.first.high.toStringAsFixed(3),
                                          style: AppTextStyles.s14w600,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'OPEN:',
                                          style: AppTextStyles.s14w400Grey,
                                        ),
                                        Text(
                                          barList.first.open.toStringAsFixed(3),
                                          style: AppTextStyles.s14w600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'LOW:',
                                          style: AppTextStyles.s14w400Grey,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          barList.first.low.toStringAsFixed(3),
                                          style: AppTextStyles.s14w600,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'CLOSE:',
                                          style: AppTextStyles.s14w400Grey,
                                        ),
                                        Text(
                                          barList.first.close.toStringAsFixed(3),
                                          style: AppTextStyles.s14w600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 8,
                            width: double.infinity,
                            color: AppColors.kGrey,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  final double year;
  final double price;

  SalesData(this.year, this.price);
}

class Period {
  final String periodName;
  final Duration period;
  final String timespan;

  Period(this.periodName, this.period, this.timespan);
}