import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';
import 'package:jmorder_app/utils/shared_preferences_impl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'app.dart';

Future main() async {
  await DotEnv().load('.env');
  await RM.storageInitializer(SharedPreferencesImp());
  configureDependencies();

  Intl.defaultLocale = "ko_KR";
  runApp(App());
}
