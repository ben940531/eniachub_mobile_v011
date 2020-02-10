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
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
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
        title: Text('Company dashboard'),
        backgroundColor: Colors.blue[500],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12.0,
                    child: Text(
                      this.name,
                      style: Theme.of(context).textTheme.body1,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
                title: Text('Company dashboard'),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
              title: Text('Personal functions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Front office functions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: PageView(scrollDirection: Axis.vertical, children: [
          Column(
            children: <Widget>[
              Text(
                'Sales chart',
                style: Theme.of(context).textTheme.display1,
              ),
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
          Column(
            children: <Widget>[
              Text(
                'Doc chart',
                style: Theme.of(context).textTheme.display1,
              ),
              Expanded(
                child: charts.LineChart(
                  _createSampleData(),
                  animate: true,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
