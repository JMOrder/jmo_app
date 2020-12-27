import 'package:flutter/material.dart';
import 'package:jmorder_app/widgets/pages/auth_page.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class GlobalExceptionUIHandler {
  static void showUnexpectedErrorDialog() {
    RM.navigate.toDialog(AlertDialog(
      title: Text("오류"),
      content: Text("예상치 못한 오류가 발생했습니다."),
      actions: <Widget>[
        FlatButton(
          child: Text("닫기"),
          onPressed: () => RM.navigate.back(),
        ),
      ],
    ));
  }

  static void showSessionExpiredDialog() {
    RM.navigate.toDialog(AlertDialog(
      title: Text("세션 만료"),
      content: Text("세션이 만료되었습니다. 다시 로그인해주십시요."),
      actions: <Widget>[
        FlatButton(
            child: Text("Close"),
            onPressed: () =>
                RM.navigate.toNamedAndRemoveUntil(AuthPage.routeName)),
      ],
    ));
  }
}
