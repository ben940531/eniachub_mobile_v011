import 'dart:convert';

import 'package:eniachub_mobile_v011/classes/Entity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckInAPI extends StoredProcBase {
  final bool inOut;

  const CheckInAPI(
      {this.inOut,
      String databaseName,
      String serverName,
      String apiServer,
      int currentBuild,
      String connectionId})
      : super(
          currentBuild: currentBuild,
          databaseName: databaseName,
          serverName: serverName,
          apiServer: apiServer,
          connectionId: connectionId,
        );
}

class CheckIn extends StatefulWidget {
  final StoredProcBase spBase;

  const CheckIn({this.spBase});

  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  String _checkInStatus = 'undefined';

  Future<void> _checkIn(bool inOut) async {
    CheckInAPI checkInAPI = CheckInAPI(
      inOut: inOut,
      currentBuild: widget.spBase.currentBuild,
      databaseName: widget.spBase.databaseName,
      serverName: widget.spBase.serverName,
      apiServer: widget.spBase.apiServer,
      connectionId: widget.spBase.connectionId,
    );

    String url = widget.spBase.apiServer + 'pEBP_Work_CheckInOut';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonbody = json.encode(checkInAPI);

    http.Response response =
        await http.post(url, headers: headers, body: jsonbody);
    if (response.statusCode == 200) {
      print('check in api repsonse: ${response.body}');
    } else {
      throw Exception('Cannot call API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  textColor: Colors.white,
                  onPressed: () async {
                    await _checkIn(true);
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
                  textColor: Colors.white,
                  onPressed: () async {
                    await _checkIn(false);
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
    );
  }
}
