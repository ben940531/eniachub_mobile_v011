import 'package:camera/camera.dart';
import 'package:eniachub_mobile_v011/classes/Entity.dart';
import 'package:eniachub_mobile_v011/pages/checkin.dart';
import 'package:eniachub_mobile_v011/pages/company.dart';
import 'package:eniachub_mobile_v011/pages/frontoffice.dart';
import 'package:eniachub_mobile_v011/pages/home.dart';
import 'package:eniachub_mobile_v011/pages/login.dart';
import 'package:eniachub_mobile_v011/pages/personal.dart';
import 'package:eniachub_mobile_v011/pages/takepicture.dart';
import 'package:eniachub_mobile_v011/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

AuthService authService = new AuthService();
Widget _defaultHome;
CameraDescription _firstCamera;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _defaultHome = LoginPage();
  bool _result = await authService.login(null);
  if (_result) {
    _defaultHome = HomePage(); //LoginPage();
  }
  final cameras = await availableCameras();
  _firstCamera = cameras.first;
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
          hintColor: Colors.grey[800],
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
        onGenerateRoute: (settings) {
          final Entity args = settings.arguments;
          if (settings.name == CompanyPage.routeName) {
            return MaterialPageRoute(builder: (context) {
              return CompanyPage(
                name: args.companyName,
                connectionId: args.gId,
              );
            });
          }
          if (settings.name == PersonalPage.routeName) {
            return MaterialPageRoute(builder: (context) {
              return PersonalPage(
                name: args.companyName,
                connectionId: args.gId,
              );
            });
          }
          if (settings.name == CheckInPage.routeName) {
            return MaterialPageRoute(builder: (context) {
              return CheckInPage(
                name: args.companyName,
                connectionId: args.gId,
              );
            });
          }
          if (settings.name == FrontOfficePage.routeName) {
            return MaterialPageRoute(builder: (context) {
              return FrontOfficePage(
                name: args.companyName,
                connectionId: args.gId,                
              );
            });
          }
          return null;
        },
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
          '/takePicture': (BuildContext context) => TakePicturePage(
                camera: _firstCamera,
              ),
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
