import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _verificationTextController = TextEditingController();

  Future<Null> signIn() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Processing Data...'),
      ));
      //Start loading indicator
      setState(() {
        //_isLoading = true;
      });
      // Log in
      var _result =
          true; //await appAuth.login(_verificationTextController.text);
      // After logging in
      if (_result) {
        setState(() {
          // _isLoading = false;
        });
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Cannot sign in'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
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
                  SizedBox(
                    height: 200,
                  ),
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
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
