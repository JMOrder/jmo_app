import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/bloc/integration/integration_bloc.dart';
import 'package:jmorder_app/bloc/integration/integration_event.dart';
import 'package:jmorder_app/bloc/integration/integration_state.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/widgets/components/auth/sign_up_form.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IntegrationPage extends StatefulWidget {
  static const String routeName = '/integration';
  final Auth auth;

  const IntegrationPage({Key key, this.auth}) : super(key: key);

  @override
  _IntegrationPageState createState() => _IntegrationPageState(this.auth);
}

class _IntegrationPageState extends State<IntegrationPage> {
  final Auth auth;
  final _phoneController = TextEditingController();
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: "###-####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );
  bool isUserFound = false;

  _IntegrationPageState(this.auth);

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneMaskFormatter.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntegrationBloc>(
      create: (BuildContext context) =>
          IntegrationBloc(IntegrationRequiredState(auth: auth)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFF0844),
          centerTitle: true,
          title: Text(
            // TODO: Change to "'플랫폼'과 연동"
            FlutterI18n.translate(
              context,
              "sign_up.app_bar.title",
            ),
          ),
        ),
        body: BlocConsumer<IntegrationBloc, IntegrationState>(
            listener: (context, state) {
          if (state is IntegratableUserFound) {
            this.setState(() {
              isUserFound = true;
            });
          }
          if (state is PerformSuccess) {
            BlocProvider.of<AuthBloc>(context)
                .add(FetchProfile(auth: state.auth));
            Navigator.of(context).pop();
          }
        }, builder: (context, integrationState) {
          return LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: TextFormField(
                                key: ValueKey("text"),
                                enabled: !isUserFound,
                                controller: _phoneController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [_phoneMaskFormatter],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "휴대폰 번호",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () async =>
                                        BlocProvider.of<IntegrationBloc>(
                                                context)
                                            .add(CheckIntegration(
                                                phone: _phoneMaskFormatter
                                                    .getUnmaskedText())),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<IntegrationBloc, IntegrationState>(
                              builder: (context, state) {
                                if (state is RegistrationRequired) {
                                  print(auth.toJson());
                                  return SignUpForm();
                                } else if (state is IntegratableUserFound) {
                                  return Container(
                                    height: 40.0,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 35),
                                    child: RaisedButton(
                                      onPressed: () async {
                                        if (!isUserFound) return;
                                        BlocProvider.of<IntegrationBloc>(
                                                context)
                                            .add(PerformIntegration(
                                          phone: _phoneMaskFormatter
                                              .getUnmaskedText(),
                                          auth: auth,
                                        ));
                                      },
                                      color: Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "연동하기",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: 0,
                                    height: 0,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
