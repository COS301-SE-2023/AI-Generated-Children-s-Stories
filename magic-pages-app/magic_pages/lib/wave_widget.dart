import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveHeaderWidget extends StatelessWidget {
  const WaveHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        colors: [
          const Color(0xFF84370F),
          const Color(0xFFFE8D29),
          const Color(0xFFFFF3E9),
        ],
        durations: [
          16000,
          18000,
          22000,
        ],
        heightPercentages: [
          -0.08,
          -0.07,
          -0.0525,
        ],
      ),
      size: Size(MediaQuery.of(context).size.width, 1000),
      waveAmplitude: 0,
    );
  }
}