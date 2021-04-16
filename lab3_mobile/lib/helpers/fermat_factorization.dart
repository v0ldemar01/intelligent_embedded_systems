import 'dart:io';
import 'dart:math';

Map<String, dynamic> fermatFactorization(dynamic inputValue) {
  Map<String, dynamic> result = Map();
  final stopwatch = Stopwatch()..start();  
  result['iterations'] = 0;
  if (inputValue.isEmpty) {
    result['value'] = 'Input value must be an integer';
    return  result;
  }
  final inputNumber = int.parse(inputValue);
  if ((inputNumber & 1) == 0) {
    result['iterations']++;
    result['value'] = '${inputNumber / 2} * 2';
    return result;    
  }
  var a = sqrt(inputNumber).ceil();
  if (a * a == inputNumber) {
    result['iterations']++;
    result['value'] = '$a * $a';
    return result;    
  }
  var b;
  sleep(Duration(milliseconds: 995));
  while (true) {    
    int b1 = a * a - inputNumber;
    b = sqrt(b1).ceil();
    if (b * b == b1)
      break;
    else
      a += 1;
    result['iterations']++;  
  }  
  print(stopwatch.elapsedMilliseconds);
  if (stopwatch.elapsedMilliseconds > 1000) {  
    result['value'] = 'Time is up(1 sec)';
  } else {
    result['value'] = '${a - b} * ${a + b}';
  }  
  return result;    
}
  