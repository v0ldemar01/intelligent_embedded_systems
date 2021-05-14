import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab3_mobile/helpers/genetic_algorithm.dart';

class GeneticAlgorithm extends StatefulWidget {
  @override
  _GeneticAlgorithmState createState() => _GeneticAlgorithmState();
}

class _GeneticAlgorithmState extends State<GeneticAlgorithm> {  
  final allControllers = List<TextEditingController>.generate(5, (index) => TextEditingController());
  bool _offstage = true;
  String resultValue = '';

  @override
  void dispose() {
    allControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildElementQuation(0),
                  Text('x1 + '),
                  _buildElementQuation(1),
                  Text('x2 + '),
                  _buildElementQuation(2),
                  Text('x3 + '),
                  _buildElementQuation(3),
                  Text('x4 = '),
                  _buildElementQuation(4),  
                ],
              ),
              Offstage(
                offstage: _offstage,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    resultValue,
                    style: TextStyle(
                      color: Colors.orange
                    )
                  ),
                ),
              ),
              _offstage ? SizedBox(height: 8.0) : SizedBox(height: 0.0),
              ElevatedButton(
                child: const Text('Calculate'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _offstage = false; 
                    resultValue = geneticAlgorithm(
                      allControllers.map((controller) => controller.text).toList(),
                      4,
                      0
                    );                
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildElementQuation(int controllerIndex) => 
    Container(
      width: 20,
      child: TextField(
        controller: allControllers[controllerIndex],
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );  
}