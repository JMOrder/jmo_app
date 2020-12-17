import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF0844),
        centerTitle: true,
        title: Text(
          FlutterI18n.translate(
            context,
            "sign_up.app_bar.title",
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFFFF0844), Color(0xFFFFB199)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
