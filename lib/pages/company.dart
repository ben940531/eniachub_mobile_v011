import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  static const routeName = '/company';
  final String connectionId;
  final String name;

  const CompanyPage({
    Key key,
    @required this.name,
    @required this.connectionId,
  }) : super(key: key);

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(1990, 100),
      new LinearSales(2000, 75),
      new LinearSales(2010, 25),
      new LinearSales(2020, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blue[500],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Text('Sales chart',style: Theme.of(context).textTheme.display1,),
            Expanded(
              child: charts.PieChart(
                _createSampleData(),
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                    arcRendererDecorators: [new charts.ArcLabelDecorator()]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
