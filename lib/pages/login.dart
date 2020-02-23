import 'package:eniachub_mobile_v011/pages/home.dart';
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

  @override
  void initState() {
    super.initState();
    //checkLogin();
  }

  Future<void> checkLogin() async {
    bool _result = await authService.login(null);
    if (_result) {
      Navigator.pushNamed(
        context,
        HomePage.routeName,
      );
    }
  }

  Future<Null> signIn() async {
    if (_formKey.currentState.validate()) {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('Processing Data...'),
      // ));
      //Start loading indicator
      // setState(() {
      //   _isLoading = true;
      // });

      EasyLoading.show(status: 'Loading');
      // Log in
      var _result = await authService.login(_verificationTextController.text);
      // After logging in
      if (_result) {
        // setState(() {
        //    _isLoading = false;
        // });
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
        EasyLoading.dismiss();
        _verificationTextController.clear();
        Navigator.pushNamed(context, '/home');
      } else {
        EasyLoading.showError('Failed to log in',
            duration: Duration(seconds: 3));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[500],
      body: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'eniacHUB Mobile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: .6,
                  ),
                ),
                SizedBox(
                  height: 100.0,
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
                    width: MediaQuery.of(context).size.width - 50,
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
                          height: 20.0,
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () {
                              // Hide on screen keyboard
                              FocusScope.of(context).requestFocus(FocusNode());
                              signIn();
                            },
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.button,
                                // fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        // ),
                      ],
                    ),
                  ),
                ),

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
      ),
    );
  }
}
