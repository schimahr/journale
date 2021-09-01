import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CircleIndicator extends StatelessWidget {
  const CircleIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 0.10,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
        ),
      ),
    );
  }
}
