import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/fermat_factorization.dart';

class FermatFactorization extends StatefulWidget {
  @override
  _FermatFactorizationState createState() => _FermatFactorizationState();
}

class _FermatFactorizationState extends State<FermatFactorization> {
  final _numberController = TextEditingController();
  String resultValue = '';
  String iterations = '';
  bool _offstage = true;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _numberController,
              decoration: new InputDecoration(labelText: "Enter your number"),
              autocorrect: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            Offstage(
              offstage: _offstage,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      resultValue,
                      style: TextStyle(
                        color: resultValue.contains('*')
                          ? Colors.orange
                          : Colors.red
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Iterations: $iterations',
                      style: TextStyle(
                        color: Colors.green
                      ),
                    ),
                  ],
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
                  final result = fermatFactorization(_numberController.text);                  
                  resultValue = result['value'];
                  iterations = result['iterations'].toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
