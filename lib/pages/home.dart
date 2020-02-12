import 'package:eniachub_mobile_v011/classes/Entity.dart';
import 'package:eniachub_mobile_v011/pages/company.dart';
import 'package:eniachub_mobile_v011/services/authService.dart';
import 'package:flutter/material.dart';

AuthService _authService = new AuthService();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Null> _signOut() async {
    var _result = await _authService.logout();
    if (_result) {
      //go back to login page
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
    }
  }

  List<Entity> _widgetList = [
    Entity('ENIAC Development', 'abc'),
    Entity('DataStore', 'abc2'),
  ];

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
      body: WillPopScope(
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 80),
                  itemCount: _widgetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            CompanyPage.routeName,
                            arguments: _widgetList[index],
                          );
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            _widgetList[index].name,
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          onWillPop: _onBackPress),
    );
  }
}
