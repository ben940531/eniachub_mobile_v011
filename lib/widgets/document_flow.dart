import 'package:eniachub_mobile_v011/classes/document.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentFlow extends StatelessWidget {
  final List<Document> _documents = [
    Document(
        crmid: 1,
        subject: 'Invoice 001',
        date: DateTime.now(),
        partnerName: 'MOLO Solutions'),
    Document(
        crmid: 2,
        subject: 'Invoice 002',
        date: DateTime.parse('20200601'),
        partnerName: 'MOLO Solutions'),
    Document(
        crmid: 3,
        subject: 'Contract 001',
        date: DateTime.parse('20200529'),
        partnerName: 'MÁV Zrt.'),
    Document(
        crmid: 4,
        subject: 'Ticket 001',
        date: DateTime.parse('20200430'),
        partnerName: 'MÁV Zrt.'),
    Document(
        crmid: 5,
        subject: 'Invoice 003',
        date: DateTime.parse('20200422'),
        partnerName: 'BKK Zrt.'),
    Document(
        crmid: 6,
        subject: 'Invoice 004',
        date: DateTime.now(),
        partnerName: 'BUX Zrt'),
    Document(
        crmid: 7,
        subject: 'Ticket 002',
        date: DateTime.parse('20200303'),
        partnerName: 'Számlázó cég'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _documents.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _documents[index].subject,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(DateFormat('yyyy.MM.dd')
                        .format(_documents[index].date)),
                  ],
                ),
                Text(_documents[index].partnerName),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {},
                        child: Icon(Icons.check),
                        textColor: Colors.green,
                      ),
                      OutlineButton(
                        onPressed: () {},
                        child: Icon(Icons.close),
                        textColor: Colors.red,
                        highlightedBorderColor: Colors.red,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
