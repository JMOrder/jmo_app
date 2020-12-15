import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/bloc/auth/auth_state.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/utils/router.dart';
import 'package:jmorder_app/widgets/components/auth/minute_second_timer.dart';
import 'package:jmorder_app/widgets/components/dialog/auth/registration_dialog.dart';
import 'package:jmorder_app/widgets/pages/registration_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class VerificationPage extends StatefulWidget {
  static const String routeName = '/integration';
  final Auth auth;

  const VerificationPage({Key key, this.auth}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState(this.auth);
}

class _VerificationPageState extends State<VerificationPage> {
  final Auth auth;
  final _phoneController = TextEditingController();
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: "###-####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );
  final _otpController = TextEditingController();
  bool isUserFound = false;

  _VerificationPageState(this.auth);

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneMaskFormatter.clear();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) async {
        if (state is IntegratableUserFound) {
          this.setState(() {
            isUserFound = true;
          });
        }
        if (state is RegistrationRequired) {
          Navigator.of(context).popAndPushNamed(RegistrationPage.routeName,
              arguments: RegistrationPageArgument(
                authDetail: state.authDetail,
              ));
          // showDialog(
          //   barrierDismissible: false,
          //   context: context,
          //   builder: (context) => RegistrationFormDialog(),
          // );
        }
        if (state is IncorrectOTPReceived) {}
      }, builder: (context, AuthState authState) {
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
                                      BlocProvider.of<AuthBloc>(context).add(
                                          RequestVerification(
                                              phone: _phoneMaskFormatter
                                                  .getUnmaskedText())),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is WaitingForOTP) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      child: TextFormField(
                                        key: ValueKey("text"),
                                        controller: _otpController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "인증번호",
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed: () async {
                                              BlocProvider.of<AuthBloc>(context)
                                                  .add(PerformVerification(
                                                id: state
                                                    .requestVerificationResponse
                                                    .id,
                                                otp: _otpController.text,
                                                authDetail: auth.authDetail,
                                              ));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        child: MinuteSecondTimer(
                                            expiresAt: state
                                                .requestVerificationResponse
                                                .expiresAt)),
                                  ],
                                );
                              } else if (state is IntegratableUserFound) {
                                return Container(
                                  height: 40.0,
                                  margin: EdgeInsets.symmetric(horizontal: 35),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      // if (!isUserFound) return;
                                      // BlocProvider.of<AuthBloc>(
                                      //         context)
                                      //     .add(PerformVerification(
                                      //   phone: _phoneMaskFormatter
                                      //       .getUnmaskedText(),
                                      //   auth: auth,
                                      // ));
                                    },
                                    color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
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
    );
  }
}
