import 'package:flutter/material.dart';
import 'package:sms_analytics/api/sms_manager.dart';
import 'package:sms_analytics/api/routes.dart';

class SmsLoaderPage extends StatefulWidget {
  _SmsLoaderPageState createState() => new _SmsLoaderPageState();
}

class _SmsLoaderPageState extends State<SmsLoaderPage> {
  Widget _loadingStateWidget = new Column(
    children: <Widget>[
      new CircularProgressIndicator(),
      new Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: new Text('Your messages are being retrieved...'),
      )
    ],
  );

  Widget buildProgressIndicator(int current, int total) {
    return new Column(
      children: <Widget>[
        new LinearProgressIndicator(value: current / total),
        new Container(
          padding: const EdgeInsets.all(8.0),
          child: new Text('Processing $current / $total messages'),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    SmsManager smsManager = SmsManager.getInstance();

    smsManager.loadAllMessages(
        onProgress: ({ int current, int total }) {
          setState(() {
            _loadingStateWidget = buildProgressIndicator(current, total);
          });
        }
    ).then((_) {
      Navigator.of(context).popAndPushNamed(SmsSearchAppRoute.Statistics);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.only(bottom: 8.0),
                child: new Text(
                    'Loading your SMS messages',
                    style: new TextStyle(fontSize: 24.0)
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(bottom: 16.0),
                child: new Text(
                    'This may take a while if you text a lot...',
                    style: new TextStyle(fontSize: 18.0, color: Colors.black26)
                ),
              ),
              _loadingStateWidget
            ],
          ),
        ),
      ),
    );
  }
}