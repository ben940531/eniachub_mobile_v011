import 'package:charts_flutter/flutter.dart' as charts;

class ChartEntity {
  final String xValue;
  final int yValue;

  ChartEntity(
    this.xValue,
    this.yValue,
  );

  static List<charts.Series<ChartEntity, String>> createSampleData() {
    final data = [
      ChartEntity('Monday', 8),
      ChartEntity('TuesDay', 7),
      ChartEntity('Wednesday', 8),
      ChartEntity('Thursday', 9),
      ChartEntity('Friday', 6),
    ];

    return [
      new charts.Series<ChartEntity, String>(
        id: 'Presence',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartEntity entity, _) => entity.xValue,
        measureFn: (ChartEntity entity, _) => entity.yValue,
        data: data,
      )
    ];
  }
}
