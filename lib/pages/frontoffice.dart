import 'dart:io';

import 'package:flutter/material.dart';

class FrontOfficePage extends StatefulWidget {
  static const String routeName = '/frontoffice';
  final String name;
  final String connectionId;

  const FrontOfficePage({
    Key key,
    @required this.name,
    @required this.connectionId,    
  }) : super(key: key);

  @override
  _FrontOfficePageState createState() => _FrontOfficePageState();
}

class _FrontOfficePageState extends State<FrontOfficePage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _rows = [
    {"ID": "1", "Number": "0", "ImagePath": ""},
  ];

  final TextEditingController _numberFieldController = TextEditingController();
  TabController _tabController;
  var _imagePath;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Front office page'),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.check)),
          ],
        ),
      ),
      body: Builder(
        builder: (context) => TabBarView(
          controller: _tabController,
          children: <Widget>[
            DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Number')),
                DataColumn(label: Text('ImagePath')),
              ],
              rows: _rows
                  .map(
                    (element) => DataRow(cells: [
                      DataCell(
                        Text(element["ID"]),
                      ),
                      DataCell(
                        Text(element["Number"]),
                      ),
                      DataCell(
                        Text(element["ImagePath"]),
                      ),
                    ]),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                TextFormField(
                  controller: _numberFieldController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Document number',
                      labelStyle: Theme.of(context).textTheme.body1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Take picture'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        final imagePath = await Navigator.pushNamed(
                          context,
                          '/takePicture',
                        );
                        setState(() {
                          _imagePath = imagePath;
                        });
                      },
                    ),
                    RaisedButton(
                      child: Text('Add'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          _rows.add({
                            "ID": (int.parse(_rows[_rows.length - 1]["ID"]) + 1)
                                .toString(),
                            "Number": _numberFieldController.text,
                            "ImagePath": _imagePath ?? ''
                          });

                          _numberFieldController.clear();
                          _imagePath = null;
                        });
                        _tabController.animateTo(0);
                      },
                    ),
                  ],
                ),
                _imagePath != null
                    ? Expanded(
                        child: Image.file(File(_imagePath)),
                      )
                    : Container(),
              ]),
            ),
          ],
        ),
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
    );
  }
}
