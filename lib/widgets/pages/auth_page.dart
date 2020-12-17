import 'package:flutter/material.dart';
import 'package:jmorder_app/services/exceptions/auth_service_exception.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/pages/verification_page.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    authState.setState((s) async {
      try {
        await s.refreshToken();
      } on RefreshTokenFailedException {
        print("Need login");
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return authState.whenRebuilderOr(
            onWaiting: () => Center(
              child: CircularProgressIndicator(),
            ),
            builder: () => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await authState.setState((s) => s.loginWithKakao());
                          RM.navigate.toNamed(VerificationPage.routeName);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:
                            Image.asset("assets/images/kakao_login_wide.png"),
                      ),
                      FlatButton(
                        onPressed: () => {
                          // TODO: NAVER OAUTH SHOULD BE IMPLEMENTED
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:
                            Image.asset("assets/images/naver_login_wide.png"),
                      ),
                      // Container(
                      //   height: 40.0,
                      //   margin: EdgeInsets.symmetric(horizontal: 35),
                      //   child: RaisedButton(
                      //     onPressed: () => showBottom(context),
                      //     color: Theme.of(context).primaryColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(5.0),
                      //     ),
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         "이메일 로그인",
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // showBottom(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: MediaQuery.of(context).viewInsets,
  //         child: Container(
  //           color: Colors.white,
  //           height: 280,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: LoginForm(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
