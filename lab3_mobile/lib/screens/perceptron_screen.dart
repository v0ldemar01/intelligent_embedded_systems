import 'package:flutter/material.dart';
import 'package:lab3_mobile/helpers/perceptron.dart';

class Perceptron extends StatefulWidget {
  @override
  _PerceptronState createState() => _PerceptronState();
}

class _PerceptronState extends State<Perceptron> {
  @override
  // ignore: override_on_non_overriding_member
  final _points = 'А(0,6), В(1,5), С(3,3), D(2,4)';
  int _thresholdOperation = 4;
  String _chosenSpeed;
  String _chosenTime;
  bool isSwitched = false;
  String _chosenIteration;
  String resultValue = '';
  bool _offstage = true;

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _points,
                  style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Threshold of operation: $_thresholdOperation',
                  style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Learning speed'),
                  ),
                  _buildDropDownElement(
                    items: ['0.001', '0.01', '0.05', '0.1', '0.2', '0.3'],
                    chosenValue: _chosenSpeed,
                    onChanged: (String value) => {
                      setState(() {
                        _chosenSpeed = value;
                      })
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Deadline:'),
                  ),
                  Row(
                    children: [
                      Text('Time'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: Colors.yellow,
                        inactiveTrackColor: Colors.blue,
                        activeColor: Colors.orangeAccent,
                      ),
                      Text('Iterations')
                    ],
                  ),
                ],
              ),
              !isSwitched
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Time'),
                      ),
                      _buildDropDownElement(
                        items: ['0.5', '1', '2', '5'],
                        chosenValue: _chosenTime,
                        onChanged: (String value) => {
                          setState(() {
                            _chosenTime = value;
                          })
                        }),
                      Text('c'),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Number of iteration'),
                      ),
                      _buildDropDownElement(
                        items: ['100', '200', '500', '1000'],
                        chosenValue: _chosenIteration,
                        onChanged: (String value) => {
                          setState(() {
                            _chosenIteration = value;
                          })
                        }
                      ),
                    ],
                  ),
              Offstage(
                offstage: _offstage,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    resultValue,
                    style: TextStyle(
                      color: resultValue.contains('*')
                          ? Colors.orange
                          : Colors.red
                        ),
                  ),
                ),
              ),
              _offstage ? SizedBox(height: 8.0) : SizedBox(height: 0.0),
              ElevatedButton(
                child: const Text('Calculate'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                onPressed: () {
                  setState(() {
                    _offstage = false;
                    resultValue = perceptron(
                      currentPoints: _points,
                      thresholdOperation: _thresholdOperation,
                      speed: double.parse(_chosenSpeed),
                      maxIterations: int.parse(_chosenIteration ?? '0'),
                      maxTime: double.parse(_chosenTime ?? '0')
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

  Widget _buildDropDownElement({
    List<String> items,
    String chosenValue,
    ValueChanged<String> onChanged
  }) =>
    DropdownButton<String>(
      value: chosenValue,
      style: TextStyle(color: Colors.black),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged
    );
}
