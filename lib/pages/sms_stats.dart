import 'package:flutter/material.dart';
import 'package:sms_analytics/api/sms_manager.dart';

class SmsStatsPage extends StatelessWidget {
  final SmsManager smsManager = SmsManager.getInstance();

  Widget buildMainDashboard(BuildContext context) {
    List<Widget> columnChildren = [
      new RichText(
          text: new TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                new TextSpan(
                    text: 'You have sent a total of '
                ),
                new TextSpan(
                    text: smsManager.getThreads()
                        .map((thread) => thread.messages.length)
                        .reduce((a, b) => a + b)
                        .toString(),
                    style: new TextStyle(color: Theme.of(context).primaryColor)
                ),
                new TextSpan(
                    text: ' SMS messages'
                ),
              ]
          )
      ),
      new RichText(
          text: new TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                new TextSpan(
                    text: 'To a total of '
                ),
                new TextSpan(
                    text: smsManager.getThreads().length.toString(),
                    style: new TextStyle(color: Theme.of(context).primaryColor)
                ),
                new TextSpan(
                    text: ' different people'
                ),
              ]
          )
      ),
    ];

    return new Container(
      padding: const EdgeInsets.all(24.0),
      child: new Column(
        children: columnChildren,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SMS Stats'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {

              })
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            buildMainDashboard(context)
          ],
        ),
      ),
    );
  }
}