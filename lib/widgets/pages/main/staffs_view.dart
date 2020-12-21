import 'package:flutter/material.dart';

class StaffsView extends StatelessWidget {
  static const int viewIndex = 0;
  static const String title = "스태프";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
          ),
          Text("페이지가 존재하지 않습니다.", style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
