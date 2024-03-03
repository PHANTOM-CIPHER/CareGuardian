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
      title: 'CareGuardian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HeartDiseasePredictionPage(),
    );
  }
}

class HeartDiseasePredictionPage extends StatefulWidget {
  @override
  _HeartDiseasePredictionPageState createState() => _HeartDiseasePredictionPageState();
}

class _HeartDiseasePredictionPageState extends State<HeartDiseasePredictionPage> {
  double? _age;
  double? _restingBloodPressure;
  double? _restingElectrocardiographicResults;
  double? _stDepression;
  double? _thal;
  double? _sex;
  double? _serumCholesterol;
  double? _maxHeartRate;
  double? _slopeOfPeakExercise;
  double? _chestPainTypes;
  double? _fastingBloodSugar;
  double? _exerciseInducedAngina;
  double? _majorVesselsColored;
  String _heartDiseaseResult = '';

  final _formKey = GlobalKey<FormState>();

  void _calculateHeartDiseaseResult() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/heart_disease_prediction"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "Age": _age,
          "RestingBloodPressure": _restingBloodPressure,
          "RestingElectrocardiographicResults": _restingElectrocardiographicResults,
          "StDepression": _stDepression,
          "Thal": _thal,
          "Sex": _sex,
          "SerumCholesterol": _serumCholesterol,
          "MaxHeartRate": _maxHeartRate,
          "SlopeOfPeakExercise": _slopeOfPeakExercise,
          "ChestPainTypes": _chestPainTypes,
          "FastingBloodSugar": _fastingBloodSugar,
          "ExerciseInducedAngina": _exerciseInducedAngina,
          "MajorVesselsColored": _majorVesselsColored,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        setState(() {
          double predictionResult = result['prediction'];
          _heartDiseaseResult = predictionResult > 0.5 ? 'Positive' : 'Negative';
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
          title: Text('Heart Disease Prediction Result'),
          content: Text('The prediction result is: $_heartDiseaseResult'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
        title: Text('Heart Disease Prediction'),
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
                  buildTextFormField(
                    'Resting Blood Pressure',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _restingBloodPressure = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Resting Electrocardiographic Results',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _restingElectrocardiographicResults = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'St Depression Induced by Exercise',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _stDepression = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Thal',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _thal = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Sex',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _sex = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Serum Cholesterol in mg/dL',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _serumCholesterol = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Maximum Heart Rate Achieved',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _maxHeartRate = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Slope of the Peak Exercise ST Segment',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _slopeOfPeakExercise = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Chest Pain Types',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _chestPainTypes = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Fasting Blood Sugar > 120 mg/dL',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _fastingBloodSugar = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Exercise Induced Angina',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _exerciseInducedAngina = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Major Vessels Colored by Fluoroscopy',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _majorVesselsColored = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _calculateHeartDiseaseResult,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Text(
                        'Heart Disease Result',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      '$_heartDiseaseResult',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
