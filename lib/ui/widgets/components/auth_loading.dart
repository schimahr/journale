import 'dart:ui';
import 'package:flutter/material.dart';
import 'circle_indicator.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF6A8448),
            Color(0xFF55693A),
            Color(0xFF404F2B),
            Color(0xFF364224)
          ], stops: [
            0.2,
            0.4,
            0.6,
            0.8
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: CircleIndicator(),
      ),
    );
  }
}
