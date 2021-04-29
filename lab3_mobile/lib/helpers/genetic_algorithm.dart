import 'dart:math';

String geneticAlgorithm(
  List<String> inputEquation,
  int numberPopulations,
  int maxIterations
) {
  List<String> result = List.empty(growable: true);
  final resultIteration1 = geneticAlgorithmCalc(inputEquation, numberPopulations, maxIterations);
  final resultIteration2 = geneticAlgorithmCalc(inputEquation, numberPopulations * 2, maxIterations);

  result.addAll([resultIteration1, resultIteration2]);
  if (int.parse(resultIteration1.split(': ').last) < int.parse(resultIteration2.split(': ').last)) {
    result.add('Не варто було збільшувати кількість популяцій');
  } else {
    result.add('Збільшення кількості популяцій було варте того');
  }
  return result.join('\n');
}

String geneticAlgorithmCalc(
  List<String> inputEquation,
  int numberPopulations,
  int maxIterations
) {
  final stopwatch = Stopwatch()..start();
  final inputCoefficients = List.generate(inputEquation.length, 
    (index) => int.parse(inputEquation[index]));
  final yValue = inputCoefficients.removeLast();
  final maxCoefficient = inputCoefficients.reduce(max);
  final maxGeneValue = (yValue/maxCoefficient).ceil();
  var currentPopulation = generateStartPopulation(
    numberPopulations, 
    inputCoefficients.length, 
    maxGeneValue
  );  
  var iterations = maxIterations;
  var iterationCounter = 0;
  while(iterations == 0 || iterations > 0) {
    iterationCounter++;
    List<int> result;
    final deltasFitness = currentPopulation.map<int>((chromosome) {
      final delta = calcFitness(inputCoefficients, chromosome, yValue);
      if (delta == 0) result = chromosome;
      return delta;
    }).toList();
    if (result != null) return result.toString() + '\ntime: ${stopwatch.elapsedMilliseconds / 1000}\niterations: $iterationCounter';    
    final probabilities = calcProbability(deltasFitness);     
    final rouletteElements = currentPopulation
      .asMap()
      .map((index, element) {
        Map<String, dynamic> chromosomeExt = Map();
        chromosomeExt['chromosome'] = element;
        chromosomeExt['probability'] = probabilities[index];
        return MapEntry(index, chromosomeExt);
      })
      .values
      .toList();
    currentPopulation = [];  
    for (var i = 0; i < numberPopulations/2; i++) {
      final selectedGenes = calcRoulette(rouletteElements);
      final mixedGenes = mixChromosomesGene(selectedGenes);
      final mutatedGenes = mixedGenes.map(
        (gene) => calcMutation(gene, maxGeneValue));
      currentPopulation..addAll(mutatedGenes);
    }
    if (maxIterations != 0) 
    iterations--;
  }
}

int generateRandomValue(int max) => Random().nextInt(max);

List<List<int>> generateStartPopulation(int numberPopulations, int varNumber, int yMax) => 
  List.generate(numberPopulations, (index) => List.generate(varNumber, (index) => generateRandomValue(yMax)));

int calcFitness(List<int> inputCoefficients, List<int> chromosome, int yValue) {
  var sum = 0;  
  chromosome.asMap().forEach((index, gene) => sum += gene * inputCoefficients[index]);
  return (yValue - sum).abs();
}  

double calcInvertedSumDeltas(List<int> deltas) => deltas.fold<double>(0, (previousValue, currentValue) => previousValue + 1 / currentValue);
List<double> calcProbability(List<int> deltas) =>  
  deltas.map<double>((delta) => 1 / delta / calcInvertedSumDeltas(deltas)).toList();

List<List<int>> calcRoulette(List<Map<String, dynamic>> elements, {numWins = 2}) =>
  List.generate(numWins, (index) => selectRandom(elements));    

List<int> selectRandom(List<Map<String, dynamic>> elements) {
  var randomValue = Random().nextDouble();
  List<List<int>> result = [];
  elements
    .forEach((element) => 
      (randomValue -= element['probability']) < 0 ? result.add(element['chromosome']) : null);
  return result[0];
}

List<List<int>> mixChromosomesGene(List<List<int>> parents) {
  final parentFirst = parents[0];
  final parentSecond = parents[1];
  final index = (parentFirst.length / 2).floor();
  return [
    [...parentFirst.sublist(0, index), ...parentSecond.sublist(index)],
    [...parentSecond.sublist(0, index), ...parentFirst.sublist(index)]
  ];
}

List<int> calcMutation(List<int> chromosome, int maxGene, {double thresholdProbability = 0.1}) {
  final random = Random().nextDouble();
  final value = Random().nextInt(maxGene);
  final i = Random().nextInt(chromosome.length);
  if (thresholdProbability >= random) {
    return chromosome.asMap().map((index, gene) =>
      MapEntry(index, i == index ? value : gene)
    )
    .values
    .toList();
  }
  return chromosome;
}

void main() {
  print(geneticAlgorithm(['1', '1', '2', '4', '45'], 4, 0));  
}