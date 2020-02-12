import 'package:flutter/material.dart';

class CheckInPage extends StatefulWidget {
  static const String routeName = '/checkin';
  final String connectionId;
  final String name;

  const CheckInPage({
    Key key,
    @required this.name,
    @required this.connectionId,
  }) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  String _checkInStatus = 'undefined';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Check in/out'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Current status:'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _checkInStatus,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('Check in'),
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          _checkInStatus = 'Checked in';
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('Check out'),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          _checkInStatus = 'Checked out';
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
