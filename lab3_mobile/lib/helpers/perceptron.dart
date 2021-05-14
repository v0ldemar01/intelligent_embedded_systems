import 'package:flutter/material.dart';

String perceptron({
  @required String currentPoints,
  @required int thresholdOperation,
  @required double speed,
  int maxIterations,
  double maxTime
}) {
  double w1 = 0;
  double w2 = 0;
  double time = 0;
  int iterations = 0;
  final parsedStr = currentPoints.replaceAll(new RegExp(r'(\D)'), '').split('');
  final points = List.generate(parsedStr.length ~/ 2,
    (i) => [int.parse(parsedStr[2 * i]), int.parse(parsedStr[2 * i + 1])]
  );
  
  final stopwatch = Stopwatch()..start();
  while (maxIterations != 0 && maxIterations > iterations ||
    maxTime != 0 && maxTime*1000 > stopwatch.elapsedMilliseconds
  ) {
    points.forEach((point) {
      final currentY = calcY(point, w1, w2);
      final delta = calcDelta(thresholdOperation, currentY);
      w1 += weightCalc(point[0], delta, speed);
      w2 += weightCalc(point[1], delta, speed);
    });    
    iterations++;
  }
  time = stopwatch.elapsedMilliseconds / 1000;
  return 'W1: $w1,\nW2: $w2,\ntime: $time,\niterations: $iterations';
}

double calcY(List<int> point, double w1, double w2) =>
  point[0] * w1 + point[1] * w2;

double calcDelta(int thresholdOperation, double y) =>
  thresholdOperation - y ?? 0;

double weightCalc(
  int point, double delta, double speed
) => point * delta * speed;
