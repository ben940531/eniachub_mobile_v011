import 'package:eniachub_mobile_v011/classes/Entity.dart';
import 'package:eniachub_mobile_v011/pages/checkin.dart';
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
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    bottom: 12.0,
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Check in/out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  CheckInPage.routeName,
                  arguments: Entity(widget.name, widget.connectionId),
                );
              },
            ),
            ListTile(
              title: Text('Back to previous page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
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
                        'Checked in',
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
