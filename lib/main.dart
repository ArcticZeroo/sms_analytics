import 'package:flutter/material.dart';
import 'package:sms_analytics/api/routes.dart';
import 'package:sms_analytics/pages/sms_loader.dart';
import 'package:sms_analytics/pages/sms_stats.dart';

void main() => runApp(new MaterialApp(
  color: Colors.blue,
  home: new SmsLoaderPage(),
  routes: {
    '${SmsSearchAppRoute.Statistics}': (BuildContext context) => new SmsStatsPage()
  },
));