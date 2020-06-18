import 'dart:convert';

import 'package:eniachub_mobile_v011/classes/Entity.dart';
import 'package:eniachub_mobile_v011/classes/firebase_notification_handler.dart';
import 'package:eniachub_mobile_v011/pages/company.dart';
import 'package:eniachub_mobile_v011/pages/webviewer.dart';
import 'package:eniachub_mobile_v011/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

AuthService _authService = new AuthService();
FirebaseNotificationManager _fcmManager = FirebaseNotificationManager();

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiBase = 'https://eniac-eniactest.azurewebsites.net/api/v1';
  bool _entitiesFetched = false;
  int _selectedIndex = 0;
  Future<Null> _signOut() async {
    var _result = await _authService.logout();
    if (_result) {
      //go back to login page
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<String> fetchEntities() async {
    final authGid = await _authService.getVerificationTokenLocal();
    final response = await http.get('$_apiBase/Entities?authGid=$authGid');
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List<dynamic>;
      print("entities response body: $body");
      var objects = body.map((b) {
        return Entity.fromJson(b);
      }).toList();
      if (objects.length == 1) {
        Navigator.pushNamed(
          context,
          CompanyPage.routeName,
          arguments: entities[0],
        );
      }

      setState(() {
        entities = objects;
        _entitiesFetched = true;
      });
      return "Success";
    } else {
      setState(() {
        //in order to stop circularprogressindicator
        _entitiesFetched = true;
      });
      throw Exception('Cannot load entities');
    }
  }

  List<Entity> entities;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _entitiesFetched = false;
    fetchEntities();

    _fcmManager.firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onmessage: $message");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              WebViewerPage(message['data']['url'])));
                    },
                  ),
                ],
              ));
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebViewerPage(message['data']['url'])));
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebViewerPage(message['data']['url'])));
    });
  }

  // List<Entity> _widgetList = [
  //   Entity(companyName: 'ENIAC Development', gId: 'abc'),
  //   Entity(companyName: 'DataStore', gId: 'abc2'),
  // ];

  Future<bool> _onBackPress() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Are you sure, you want to exit?"),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[Text("Cancel")],
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: _signOut,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        Text('Sign out')
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        });
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _entitiesFetched
          ? WillPopScope(
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 80),
                      itemCount: entities != null ? entities.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            leading: entities[index].logoPath == null
                                ? FlutterLogo()
                                : Image.network(entities[index].logoPath),
                            title: Text(entities[index].companyName),
                            trailing: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.blue,
                            ),
                            onTap: () => Navigator.pushNamed(
                              context,
                              CompanyPage.routeName,
                              arguments: entities[index],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              onWillPop: _onBackPress)
          : Center(
              child: Loading(
                color: Colors.blue,
                indicator: BallPulseIndicator(),
                size: 100.0,
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Accesses'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            title: Text('Services'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
