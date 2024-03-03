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
      title: 'Parkinson\'s Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ParkinsonsPredictionPage(),
    );
  }
}

class ParkinsonsPredictionPage extends StatefulWidget {
  @override
  _ParkinsonsPredictionPageState createState() => _ParkinsonsPredictionPageState();
}

class _ParkinsonsPredictionPageState extends State<ParkinsonsPredictionPage> {
  double? _mdvpFo;
  double? _mdvpRap;
  double? _shimmerApq3;
  double? _hnr;
  double? _d2;
  double? _mdvpFhi;
  double? _mdvpPpq;
  double? _shimmerApg3;
  double? _rpde;
  double? _ppe;
  double? _mdvpFlo;
  double? _jitterDdp;
  double? _mdvpApq;
  double? _dfa;
  double? _mdvpJitterPercent;
  double? _mdvpShimmer;
  double? _shimmerDda;
  double? _spread1;
  double? _mdvpJitterAbs;
  double? _mdvpShimmerDb;
  double? _nhr;
  double? _spread2;
  String _parkinsonsTestResult = '';

  final _formKey = GlobalKey<FormState>();

  void _calculateParkinsonsResult() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/parkinsons_prediction"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "MDVPFo": _mdvpFo,
          "MDVPRap": _mdvpRap,
          "ShimmerAPQ3": _shimmerApq3,
          "HNR": _hnr,
          "D2": _d2,
          "MDVPFhi": _mdvpFhi,
          "MDVPPPQ": _mdvpPpq,
          "ShimmerAPG3": _shimmerApg3,
          "RPDE": _rpde,
          "PPE": _ppe,
          "MDVPFlo": _mdvpFlo,
          "JitterDDP": _jitterDdp,
          "MDVPApq": _mdvpApq,
          "DFA": _dfa,
          "MDVPJitterPercent": _mdvpJitterPercent,
          "MDVPShimmer": _mdvpShimmer,
          "ShimmerDDA": _shimmerDda,
          "Spread1": _spread1,
          "MDVPJitterAbs": _mdvpJitterAbs,
          "MDVPShimmerDB": _mdvpShimmerDb,
          "NHR": _nhr,
          "Spread2": _spread2,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        setState(() {
          double predictionResult = result['prediction'];
          _parkinsonsTestResult = predictionResult > 0.5 ? 'Positive' : 'Negative';
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
          title: Text('Parkinson\'s Disease Prediction Result'),
          content: Text('The prediction result is: $_parkinsonsTestResult'),
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
        title: Text('Parkinson\'s Prediction'),
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
                    'MDVP:Fo (Hz)',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpFo = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:RAP',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpRap = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Shimmer:APQ3',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _shimmerApq3 = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'HNR',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _hnr = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'D2',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _d2 = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:Fhi (Hz)',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpFhi = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:PPQ',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpPpq = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Shimmer:APG3',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _shimmerApg3 = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'RPDE',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _rpde = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'PPE',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _ppe = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:Flo (Hz)',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpFlo = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Jitter:DDP',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _jitterDdp = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:APQ',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpApq = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'DFA',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _dfa = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:Jitter (%)',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpJitterPercent = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:Shimmer',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpShimmer = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Shimmer:DDA',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _shimmerDda = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Spread1',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _spread1 = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:Jitter (Abs)',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpJitterAbs = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'MDVP:Shimmer (dB)',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _mdvpShimmerDb = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'NHR',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _nhr = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  buildTextFormField(
                    'Spread2',
                    TextInputType.number,
                        (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                        (value) => _spread2 = double.parse(value!),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _calculateParkinsonsResult,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Text('Parkinson\'s Test Result', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      '$_parkinsonsTestResult',
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
