import 'package:eniachub_mobile_v011/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() => runApp(EniacHUBMobileApp());

class EniacHUBMobileApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        title: 'EniacHUB Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.grey[100],
          primaryColorLight: Colors.white,
          errorColor: Colors.red,
          hintColor: Colors.grey[300],
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.grey[300])),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
          ),
        ),
        home: Stack(
          children: <Widget>[
            LoginPage(),
          ],
        ),
      ),
    );
  }
}
