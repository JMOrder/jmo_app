import 'package:flutter/material.dart';

class AppBarGradient extends LinearGradient {
  AppBarGradient({
    List<double> stops,
    GradientTransform transform,
  }) : super(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFF47400), Color(0xFFF0EB09)],
          tileMode: TileMode.clamp,
          stops: stops,
          transform: transform,
        );
}
