import 'package:eniachub_mobile_v011/pages/home.dart';
import 'package:eniachub_mobile_v011/pages/login.dart';
import 'package:eniachub_mobile_v011/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

AuthService authService = new AuthService();
Widget _defaultHome;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _defaultHome = LoginPage();
  bool _result = await authService.login(null);
  if (_result) {
    _defaultHome = LoginPage(); //HomePage();
  }
  runApp(EniacHUBMobileApp());
}

class EniacHUBMobileApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _setUpOwnLoadingWidget();
    return FlutterEasyLoading(
      child: MaterialApp(
        title: 'EniacHUB Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          primaryColorLight: Colors.white,
          errorColor: Colors.red,
          hintColor: Colors.grey[300],
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 18.0, color: Colors.black),
            button: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.grey[700])),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(color: Colors.red, fontSize: 13.0),
          ),
        ),
        home: _defaultHome,
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
        },
      ),
    );
  }

  void _setUpOwnLoadingWidget() {
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.backgroundColor = Colors.grey[400];
    EasyLoading.instance.progressColor = Colors.black;
    EasyLoading.instance.textColor = Colors.black;
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.wave;
    EasyLoading.instance.indicatorColor = Colors.blue;
    EasyLoading.instance.indicatorSize = 80.0;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.instance.errorWidget = Icon(
      Icons.clear,
      color: Colors.red,
      size: 80.0,
    );
  }
}
