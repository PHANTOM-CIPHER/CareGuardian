import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diabetes Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiabetesPredictionPage(),
    );
  }
}

class DiabetesPredictionPage extends StatefulWidget {
  @override
  _DiabetesPredictionPageState createState() => _DiabetesPredictionPageState();
}

class _DiabetesPredictionPageState extends State<DiabetesPredictionPage> {
  double? _glucoseLevel;
  double? _skinThickness;
  double? _insulinValue;
  double? _diabetesPedigreeFunctionValue;
  int? _numberOfPregnancies;
  double? _age;
  double? _bloodPressure;
  double? _bmiValue;
  String _diabetesTestResult = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> _calculateResult() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/diabetes_prediction"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "Pregnancies": _numberOfPregnancies,
          "Glucose": _glucoseLevel,
          "BloodPressure": _bloodPressure,
          "SkinThickness": _skinThickness,
          "Insulin": _insulinValue,
          "BMI": _bmiValue,
          "DiabetesPedigreeFunction": _diabetesPedigreeFunctionValue,
          "Age": _age,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        setState(() {
          _diabetesTestResult = result['DiabetesPrediction'] == 1 ? 'Positive' : 'Negative';
        });

        // Show a pop-up with the results
        _showResultPopup();
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  void _showResultPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Diabetes Test Result'),
          content: Text('Result: $_diabetesTestResult'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextFormField(
      String labelText,
      TextInputType keyboardType,
      String? Function(String?)? validator,
      void Function(String?)? onSaved,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetes Prediction'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildTextFormField(
                    'Pregnancies',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _numberOfPregnancies = int.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Glucose',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _glucoseLevel = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'BloodPressure',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _bloodPressure = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'SkinThickness',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _skinThickness = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Insulin',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _insulinValue = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'BMI',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _bmiValue = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'DiabetesPedigreeFunction',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _diabetesPedigreeFunctionValue = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Age',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _age = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _calculateResult,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Text(
                        'Diabetes Test Result',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
