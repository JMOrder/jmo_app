import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jmorder_app/utils/service_locator.dart';
import 'app.dart';

void main() {
  ServiceLocator.setupLocator();

  Intl.defaultLocale = "ko_KR";

  runApp(App());
}
