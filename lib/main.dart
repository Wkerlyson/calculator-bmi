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

  GlobalKey<FormState> _formKey = GlobalKey();

  String _infoText = 'Enter your data';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Enter your data';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      if (bmi < 18.6) {
        _infoText = "Underweight - BMI: ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = "Ideal weight - BMI: ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = "Slightly overweight - BMI: ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = "Obesity Grade I - BMI: ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = "obesity Grade II - BMI: (${bmi.toStringAsPrecision(4)}";
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120, color: Colors.green),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        labelStyle: TextStyle(color: Colors.green)),
                    style: TextStyle(color: Colors.green, fontSize: 15),
                    validator: (value) {
                      if (value.isEmpty) return 'Enter your weight';
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    decoration: InputDecoration(
                        labelText: 'Height (cm)',
                        labelStyle: TextStyle(color: Colors.green)),
                    style: TextStyle(color: Colors.green, fontSize: 15),
                    validator: (value) {
                      if (value.isEmpty) return 'Enter your height';
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 40),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) _calculate();
                        },
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
            )));
  }
}
