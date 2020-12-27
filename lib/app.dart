import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';
import 'package:jmorder_app/utils/router.dart' as UtilRouter;
import 'package:jmorder_app/widgets/pages/auth_page.dart';
// import 'package:jmorder_app/widgets/pages/auth_page.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AuthPage.routeName,
            navigatorKey: RM.navigate.navigatorKey,
            theme: ThemeData(
              // primarySwatch: Colors.pink,
              backgroundColor: const Color(0xFFF89B6C),
              scaffoldBackgroundColor: Colors.white,
              primaryColor: const Color(0xFFF37221),
              accentColor: const Color(0xFFF33E21),
              canvasColor: const Color(0xFFfafafa),
            ),
            localizationsDelegates: [
              FlutterI18nDelegate(
                translationLoader: FileTranslationLoader(
                    basePath: "assets/i18n", fallbackFile: "ko"),
                missingTranslationHandler: (key, locale) {
                  print(
                      "--- Missing Key: $key, languageCode: ${locale.languageCode}");
                },
              ),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            onGenerateRoute: UtilRouter.Router.generateRoute,
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
