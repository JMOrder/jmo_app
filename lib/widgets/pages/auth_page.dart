import 'package:jmorder_app/utils/global_exception_ui_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/bloc/auth/auth_state.dart';
import 'package:jmorder_app/widgets/components/auth/login_form.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jmorder_app/widgets/pages/main_page.dart';
import 'package:jmorder_app/widgets/views/staffs_view.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AppLoaded());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      MainPage.routeName,
                      (r) => false,
                      arguments: StaffsView.viewIndex,
                    );
                  }
                  if (state is LoginFailureState) {
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
                  }
                  if (state is SignUpSuccessState) {
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
                  }
                  if (state is SignUpFailureState) {
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
                  }
                  if (state is UnexpectedFailureState) {
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
                      if (state is AuthInitialState ||
                          state is AuthRequestState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(100.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40.0, horizontal: 20.0),
                            child: LoginForm(),
                          )
                        ],
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
}
