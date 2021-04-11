import 'dart:math';

String fermatFactorization(dynamic inputValue) {
  if (inputValue.isEmpty) return 'Input value must be an integer';
  final inputNumber = int.parse(inputValue);
  if ((inputNumber & 1) == 0) {
    return '${inputNumber / 2} * 2';
  }
  var a = sqrt(inputNumber).ceil();
  if (a * a == inputNumber) return '$a * $a';
  var b;
  while (true) {
    int b1 = a * a - inputNumber;
    b = sqrt(b1).ceil();
    if (b * b == b1)
      break;
    else
      a += 1;
  }  
  return '${a - b} * ${a + b}';
}
