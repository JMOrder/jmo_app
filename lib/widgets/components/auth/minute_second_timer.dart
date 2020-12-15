import 'dart:async';

import 'package:flutter/material.dart';

class MinuteSecondTimer extends StatefulWidget {
  final Key key;
  final DateTime expiresAt;
  MinuteSecondTimer({@required this.expiresAt, this.key}) : super(key: key);

  @override
  _MinuteSecondTimerState createState() =>
      _MinuteSecondTimerState(expiresAt: this.expiresAt);
}

class _MinuteSecondTimerState extends State<MinuteSecondTimer> {
  Timer _timer;
  DateTime expiresAt;
  int _secondsLeft;

  _MinuteSecondTimerState({@required this.expiresAt}) {
    this._secondsLeft = expiresAt.difference(DateTime.now()).inSeconds;
    _timer = new Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (this._secondsLeft < 1) {
            timer.cancel();
          } else {
            this._secondsLeft--;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String timeLeftToString() {
    Duration secondsLeft = Duration(seconds: this._secondsLeft);
    return "${secondsLeft.inMinutes.remainder(60)}:${(secondsLeft.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.timeLeftToString()),
    );
  }
}
