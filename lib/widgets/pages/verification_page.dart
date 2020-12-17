import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/components/auth/minute_second_timer.dart';
import 'package:jmorder_app/widgets/pages/registration_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class VerificationPage extends StatefulWidget {
  static const String routeName = '/integration';

  const VerificationPage({Key key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _phoneController = TextEditingController();
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: "###-####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );
  final _otpController = TextEditingController();
  bool isUserFound = false;

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
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("번호 인증"),
      ),
      body: LayoutBuilder(
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
                                onPressed: () async => verificationState
                                    .setState((s) => s.requestVerification(
                                        _phoneMaskFormatter.getUnmaskedText())),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        verificationState.whenRebuilderOr(
                          builder: () {
                            if (verificationState.state.model == null) {
                              return SizedBox.shrink();
                            } else {
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey),
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
                                            await verificationState.setState(
                                              (s) => s.performVerification(
                                                  _otpController.text),
                                              onError: (context, error) {
                                                print(error.runtimeType);
                                                if (error is DioError) {
                                                  print("DIO!!");
                                                }
                                                if (error
                                                    is ConnectedUserNotFoundException) {
                                                  print("PLEASE!!");
                                                  RM.navigate.backAndToNamed(
                                                      RegistrationPage
                                                          .routeName);
                                                }
                                              },
                                            );
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
                                          expiresAt: verificationState
                                              .state.model.expiresAt)),
                                ],
                              );
                            }
                          },
                        ),
                        // BlocBuilder<AuthBloc, AuthState>(
                        //   builder: (context, state) {
                        //     if (state is WaitingForOTP) {
                        //       return Column(
                        //         children: [
                        //           Container(
                        //             decoration: BoxDecoration(
                        //               border: Border(
                        //                 bottom: BorderSide(color: Colors.grey),
                        //               ),
                        //             ),
                        //             child: TextFormField(
                        //               key: ValueKey("text"),
                        //               controller: _otpController,
                        //               textInputAction: TextInputAction.next,
                        //               keyboardType: TextInputType.number,
                        //               decoration: InputDecoration(
                        //                 border: InputBorder.none,
                        //                 hintText: "인증번호",
                        //                 suffixIcon: IconButton(
                        //                   icon: Icon(Icons.send),
                        //                   onPressed: () async {
                        //                     BlocProvider.of<AuthBloc>(context)
                        //                         .add(PerformVerification(
                        //                       id: state
                        //                           .requestVerificationResponse
                        //                           .id,
                        //                       otp: _otpController.text,
                        //                       authDetail: auth.authDetail,
                        //                     ));
                        //                   },
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           Container(
                        //               margin:
                        //                   EdgeInsets.symmetric(vertical: 10),
                        //               decoration: BoxDecoration(
                        //                 border: Border(
                        //                   bottom:
                        //                       BorderSide(color: Colors.grey),
                        //                 ),
                        //               ),
                        //               child: MinuteSecondTimer(
                        //                   expiresAt: state
                        //                       .requestVerificationResponse
                        //                       .expiresAt)),
                        //         ],
                        //       );
                        //     } else if (state is IntegratableUserFound) {
                        //       return Container(
                        //         height: 40.0,
                        //         margin: EdgeInsets.symmetric(horizontal: 35),
                        //         child: RaisedButton(
                        //           onPressed: () async {
                        //             // if (!isUserFound) return;
                        //             // BlocProvider.of<AuthBloc>(
                        //             //         context)
                        //             //     .add(PerformVerification(
                        //             //   phone: _phoneMaskFormatter
                        //             //       .getUnmaskedText(),
                        //             //   auth: auth,
                        //             // ));
                        //           },
                        //           color: Theme.of(context).primaryColor,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(5.0),
                        //           ),
                        //           child: Container(
                        //             alignment: Alignment.center,
                        //             child: Text(
                        //               "연동하기",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(color: Colors.white),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     } else {
                        //       return Container(
                        //         width: 0,
                        //         height: 0,
                        //       );
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegistrationState {}
