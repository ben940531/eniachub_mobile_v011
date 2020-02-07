import 'package:eniachub_mobile_v011/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final authService = AuthService();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _verificationTextController = TextEditingController();

  Future<Null> signIn() async {
    if (_formKey.currentState.validate()) {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('Processing Data...'),
      // ));
      //Start loading indicator
      // setState(() {
      //   _isLoading = true;
      // });
      EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
      EasyLoading.instance.backgroundColor = Colors.white;
      EasyLoading.instance.progressColor  = Colors.black;
      EasyLoading.instance.textColor = Colors.black;
      EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.wave;
      EasyLoading.instance.indicatorColor = Colors.blue;
      EasyLoading.instance.indicatorSize = 80.0;
      EasyLoading.instance.maskType = EasyLoadingMaskType.black;
      EasyLoading.show(status:'Loading');
      // Log in
      var _result = await authService.login(_verificationTextController.text);
      // After logging in
      if (_result) {
        // setState(() {
        //    _isLoading = false;
        // });
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
      } else {
       
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[500],
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 150.0, bottom: 150.0),
                    child: Text(
                      'eniacHUB Mobile',
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).primaryColorLight,
                        letterSpacing: .6,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 50.0),
                  //   child: Text(
                  //     'Login',
                  //     style: TextStyle(
                  //       fontSize: 30,
                  //       letterSpacing: .5,
                  //       color: Theme.of(context).primaryColorLight,
                  //     ),
                  //   ),
                  // ),
                  Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            obscureText: true,
                            controller: _verificationTextController,
                            decoration: InputDecoration(
                                hintText: "Code given by eniachub.com",
                                border: OutlineInputBorder(),
                                labelText: 'Verification code',
                                labelStyle: Theme.of(context).textTheme.body1
                                // labelStyle:
                                //     TextStyle(color: Colors.white, fontSize: 16),
                                // hintStyle:
                                //     TextStyle(color: Colors.white, fontSize: 16.0),
                                ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (val.length < 6) {
                                return 'The given verification code is too short';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: signIn,
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text('Login',
                                    style: Theme.of(context).textTheme.body1
                                    // fontSize: 18.0,
                                    ),
                              ),
                            ),
                          ),
                          // ),
                        ],
                      ),
                    ),
                  )

                  // Form(
                  //   key: _formKey,
                  //   child: Column(
                  //     children: <Widget>[
                  //       TextFormField(
                  //         obscureText: true,
                  //         controller: _verificationTextController,
                  //         validator: (val) {
                  //           if (val.isEmpty) {
                  //             return 'Please enter some text';
                  //           }
                  //           if (val.length < 6) {
                  //             return 'The given verification code is too short';
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ));
  }
}
