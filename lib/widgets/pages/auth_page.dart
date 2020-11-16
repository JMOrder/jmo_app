import 'package:get_it/get_it.dart';
import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/utils/global_exception_ui_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/bloc/auth/auth_state.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jmorder_app/widgets/pages/integration_page.dart';
import 'package:jmorder_app/widgets/pages/main_page.dart';
import 'package:jmorder_app/widgets/views/staffs_view.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AppLoaded());
    if (GetIt.I.get<AuthService>().isAuthenticated) {
      BlocProvider.of<BottomNavigationBloc>(context).add(PageTapped(index: 0));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is IntegrationRequiredState) {
                    Navigator.pushNamed(context, IntegrationPage.routeName,
                        arguments: state.auth);
                  }
                  if (state is LoginSuccessState) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      MainPage.routeName,
                      (r) => false,
                      arguments: StaffsView.viewIndex,
                    );
                  } else if (state is LoginFailureState) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            FlutterI18n.translate(
                                context, "auth.errors.login_failed.title"),
                          ),
                          content: Text(
                            FlutterI18n.translate(
                                context, "auth.errors.login_failed.content"),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (state is SignUpSuccessState) {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            FlutterI18n.translate(
                              context,
                              "sign_up.success.title",
                            ),
                          ),
                          content: Text(
                            FlutterI18n.translate(
                              context,
                              "sign_up.success.content",
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (state is SignUpFailureState) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(FlutterI18n.translate(context,
                              "sign_up.errors.email_already_exists.title")),
                          content: Text(FlutterI18n.translate(context,
                              "sign_up.errors.email_already_exists.content")),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (state is UnexpectedFailureState) {
                    GlobalExceptionUIHandler.showUnexpectedErrorDialog(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFFFF0844), Color(0xFFFFB199)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthRequestState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 100.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () =>
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(KakaoLoginSubmitted()),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Image.asset(
                                  "assets/images/kakao_login_wide.png"),
                            ),
                            FlatButton(
                              onPressed: () => {
                                // TODO: NAVER OAUTH SHOULD BE IMPLEMENTED
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Image.asset(
                                  "assets/images/naver_login_wide.png"),
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
                      );
                    },
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
