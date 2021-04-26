import 'package:flutter/material.dart';
import 'package:lab3_mobile/screens/fermat_factorization_screen.dart';
import 'package:lab3_mobile/screens/genetic_algorithm_screen.dart';
import 'package:lab3_mobile/screens/perceptron_screen.dart';
import 'package:lab3_mobile/widgets/bottom_navigation.dart';

List<Widget> _options = <Widget>[
  FermatFactorization(),
  Perceptron(),
  GeneticAlgorithm(),
];

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(allTabItems[_currentIndex].title),
        ),
      ),
      body: _options.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onSelectTab: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
