import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  static const routeName = '/personal';
  final String connectionId;
  final String name;

  const PersonalPage({
    Key key,
    @required this.name,
    @required this.connectionId,
  }) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PersonalPage'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: [
                  Positioned(
                    child: Text(
                      widget.name,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    bottom: 12.0,
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name:',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        Text(
                          'Position: ',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        Text(
                          'Office status: ',
                        ),
                        Text(
                          'Currently working on: ',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ]),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Fehér Benjámin',
                      ),
                      Text(
                        'Developer',
                      ),
                      Text(
                        'Signed in',
                      ),
                      Text('PFM Project'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
