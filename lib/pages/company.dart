import 'package:charts_flutter/flutter.dart' as charts;
import 'package:eniachub_mobile_v011/classes/chart_entity.dart';
import 'package:eniachub_mobile_v011/classes/Entity.dart';
import 'package:eniachub_mobile_v011/pages/frontoffice.dart';
import 'package:eniachub_mobile_v011/widgets/checkIn.dart';
import 'package:eniachub_mobile_v011/widgets/document_flow.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class CompanyPage extends StatefulWidget {
  static const routeName = '/company';
  final String gId;
  final String companyName;
  final StoredProcBase spBase;
  final List<Connection> connections;

  const CompanyPage({
    Key key,
    @required this.companyName,
    @required this.gId,
    @required this.spBase,
    @required this.connections,
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
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  charts.BarChart _barChart;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _getChart();
  }

  Future<void> _getChart() async {
    await Future<void>.delayed(Duration(seconds: 2), () {
      setState(() {
        _barChart = charts.BarChart(
          ChartEntity.createSampleData(),
          animate: true,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.companyName),
        backgroundColor: Colors.blue[500],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.pie_chart)),
            Tab(icon: Icon(Icons.timer)),
            Tab(icon: Icon(Icons.folder)),
          ],
        ),
      ),
      drawer: Drawer(
        child: //ListView.builder(
            //       itemCount: connections.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return ListTile(
            //           title: Text(connections[index].name),
            //         );
            //       },
            //     ),
            ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12.0,
                    child: Text(
                      this.widget.companyName,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
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
              title: Text('Front office functions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  FrontOfficePage.routeName,
                  arguments: Entity(
                      companyName: this.widget.companyName,
                      gId: this.widget.gId),
                );
              },
            ),
            ListTile(
              title: Text('Back to previous page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: PageView(scrollDirection: Axis.vertical, children: [
            _barChart != null
                ? Column(
                    children: <Widget>[
                      Text(
                        'Presence',
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Expanded(
                        child: _barChart,
                      ),
                    ],
                  )
                : Center(
                    child: Loading(
                      size: 100.0,
                      color: Colors.blue,
                      indicator: BallPulseIndicator(),
                    ),
                  ),
            Column(
              children: <Widget>[
                Text(
                  'Doc chart',
                  style: Theme.of(context).textTheme.headline,
                ),
                Expanded(
                  child: charts.LineChart(
                    CompanyPage._createSampleData(),
                    animate: true,
                  ),
                ),
              ],
            ),
          ]),
        ),
        CheckIn(spBase: widget.spBase),
        Container(
          child: DocumentFlow(),
        ),
      ]),
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
