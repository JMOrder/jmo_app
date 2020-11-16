import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:jmorder_app/utils/service_locator.dart';
import 'app.dart';

Future main() async {
  await DotEnv().load('.env');
  ServiceLocator.setupLocator();
  Intl.defaultLocale = "ko_KR";
  runApp(App());
}
