import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testovyi/src/core/resources/resources.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';

class CustomCartesianChartWidget extends StatefulWidget {
  final List<CryptoData> barList;
  const CustomCartesianChartWidget({super.key, required this.barList});

  @override
  State<CustomCartesianChartWidget> createState() => _CustomCartesianChartWidgetState();
}

class _CustomCartesianChartWidgetState extends State<CustomCartesianChartWidget> {
  TrackballBehavior? _trackballBehavior;
  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineType: TrackballLineType.none,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(canShowMarker: false),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      // title: ChartTitle(
      //     text: isCardView ? '' : 'Average annual rainfall of United Kingdom'),
      primaryXAxis: DateTimeAxis(
          // edgeLabelPlacement:
          //     model.isWebFullView ? EdgeLabelPlacement.shift : EdgeLabelPlacement.none,
          intervalType: DateTimeIntervalType.years,
          dateFormat: DateFormat('yyyy-MM-dd'),
          interval: 10,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          minimum: widget.barList.map((e) => e.close).toList().reduce(min),
          maximum: widget.barList.map((e) => e.close).toList().reduce(max),
          interval: ((widget.barList.map((e) => e.close).toList().reduce(max) -
                      widget.barList.map((e) => e.close).toList().reduce(min)) /
                  5)
              .round()
              .toDouble(),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series:
          _getLineZoneSeries(widget.barList.map((e) => e.close).toList(), widget.barList.map((e) => e.time).toList()),
      trackballBehavior: _trackballBehavior,
      onTrackballPositionChanging: (TrackballArgs args) {
        args.chartPointInfo.label = '${args.chartPointInfo.header!} : ${args.chartPointInfo.label!}';
      },

      /// To set the annotation content for chart.
      // annotations: <CartesianChartAnnotation>[
      //   CartesianChartAnnotation(
      //       widget: SizedBox(
      //           height: 375,
      //           width: 184,
      //           child: Column(
      //             // ignore: prefer_const_literals_to_create_immutables
      //             children: <Widget>[
      //               Row(children: <Widget>[
      //                 Icon(Icons.circle,
      //                     color: const Color.fromRGBO(4, 8, 195, 1),
      //                     size: size),
      //                 Text(' High', style: TextStyle(fontSize: fontSize)),
      //               ]),
      //               Row(children: <Widget>[
      //                 Icon(Icons.circle,
      //                     color: const Color.fromRGBO(26, 112, 23, 1),
      //                     size: size),
      //                 Text(' Medium', style: TextStyle(fontSize: fontSize))
      //               ]),
      //               Row(children: <Widget>[
      //                 Icon(Icons.circle,
      //                     color: const Color.fromRGBO(229, 11, 10, 1),
      //                     size: size),
      //                 Text(' Low', style: TextStyle(fontSize: fontSize))
      //               ]),
      //             ],
      //           )),
      //       coordinateUnit: CoordinateUnit.percentage,
      //       x: kIsWeb ? '95%' : '85%',
      //       y: kIsWeb
      //           ? '19%'
      //           : orientation == Orientation.portrait
      //               ? '14%'
      //               : '17%')
      // ],
    );
  }

  /// The method returns line series to chart.
  List<CartesianSeries<_ChartData, DateTime>> _getLineZoneSeries(List<double> close, List<int> timespan) {
    return <CartesianSeries<_ChartData, DateTime>>[
      LineSeries<_ChartData, DateTime>(
        animationDuration: 2500,
        dataSource: getData(close, timespan),
        color: AppColors.kGreen,
        //Set color for high, middle, low
        // onCreateShader: (ShaderDetails details) {
        //   return ui.Gradient.linear(details.rect.topCenter, details.rect.bottomCenter, <Color>[
        //     const Color.fromRGBO(4, 8, 195, 1),
        //     const Color.fromRGBO(4, 8, 195, 1),
        //     const Color.fromRGBO(26, 112, 23, 1),
        //     const Color.fromRGBO(26, 112, 23, 1),
        //     const Color.fromRGBO(229, 11, 10, 1),
        //     const Color.fromRGBO(229, 11, 10, 1),
        //   ], <double>[
        //     0,
        //     0.333333,
        //     0.333333,
        //     0.666666,
        //     0.666666,
        //     0.999999,
        //   ]);
        // },
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
      ),
    ];
  }

  List<_ChartData> getData(List<double> close, List<int> timespan) {
    final List<_ChartData> data = <_ChartData>[];
    for (int i = 0; i < close.length; i++) {
      data.add(_ChartData(DateTime.fromMillisecondsSinceEpoch(timespan[i]), close[i]));
    }
    return data;
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
