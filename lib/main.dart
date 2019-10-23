import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = 'Enter your data';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    _infoText = 'Enter your data';
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);
      print(bmi);

      if (bmi < 18.6) {
        _infoText = "Underweight (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = "Ideal weight (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = "Slightly overweight (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = "Obesity Grade I (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = "obesity Grade II (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 40) {
        _infoText = "Obesity Grade III (${bmi.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.green),
              TextField(
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    labelStyle: TextStyle(color: Colors.green)),
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: heightController,
                decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    labelStyle: TextStyle(color: Colors.green)),
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 40),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: _calculate,
                    child: Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 15),
              )
            ],
          ),
        ));
  }
}
