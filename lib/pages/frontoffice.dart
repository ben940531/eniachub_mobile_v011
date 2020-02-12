import 'package:flutter/material.dart';

class FrontOfficePage extends StatelessWidget {
  static const String routeName = '/frontoffice';
  final String name;
  final String connectionId;

  const FrontOfficePage({
    Key key,
    @required this.name,
    @required this.connectionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Front office page'),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.check)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DataTable(columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Number')),
            ], rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('12345')),
              ]),
            ]),
            Text('Tab 2'),
          ],
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     children: <Widget>[
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Stack(children: [
        //           Positioned(
        //               child: Text(
        //                 this.name,
        //                 style: TextStyle(fontSize: 18.0, color: Colors.white),
        //               ),
        //               bottom: 12.0),
        //         ]),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
