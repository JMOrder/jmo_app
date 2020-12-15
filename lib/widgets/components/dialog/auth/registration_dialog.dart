import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/widgets/pages/auth_page.dart';

class RegistrationFormDialog extends StatefulWidget {
  RegistrationFormDialog({Key key}) : super(key: key);

  @override
  _RegistrationFormDialogState createState() => _RegistrationFormDialogState();
}

class _RegistrationFormDialogState extends State<RegistrationFormDialog> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("신규가입"),
      content: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.60),
                  borderRadius: BorderRadius.circular(10),
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
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "이메일",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.60),
                  borderRadius: BorderRadius.circular(10),
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
                        controller: _lastNameController,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "성",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.60),
                  borderRadius: BorderRadius.circular(10),
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
                        controller: _firstNameController,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "이름",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        new FlatButton(
          child: new Text('취소'),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(AppLoaded());
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AuthPage.routeName, (_) => false);
          },
        ),
        new FlatButton(
          child: new Text('추가'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
