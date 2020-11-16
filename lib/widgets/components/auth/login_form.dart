import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:jmorder_app/widgets/pages/sign_up_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _submitLoginForm(context) async {
    BlocProvider.of<AuthBloc>(context).add(
      LoginSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
    _emailController.clear();
    _passwordController.clear();
    BlocProvider.of<BottomNavigationBloc>(context).add(PageTapped(index: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.20),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[100]),
                    ),
                  ),
                  child: TextFormField(
                    key: ValueKey("text"),
                    controller: _emailController,
                    focusNode: _emailFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "이메일",
                    ),
                    onFieldSubmitted: (value) =>
                        _fieldFocusChange(context, _emailFocus, _passwordFocus),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.20),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[100]),
                    ),
                  ),
                  child: TextFormField(
                    key: ValueKey("text"),
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.go,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "비밀번호",
                    ),
                    onFieldSubmitted: (value) => _submitLoginForm(context),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: RaisedButton(
              onPressed: () => _submitLoginForm(context),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "로그인",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 40.0,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () =>
                  Navigator.of(context).pushNamed(SignUpPage.routeName),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "회원가입",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
