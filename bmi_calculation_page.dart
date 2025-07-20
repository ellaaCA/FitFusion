import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      home: BMICalculationPage(),
    );
  }
}

class BMICalculationPage extends StatefulWidget {
  const BMICalculationPage({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculationPage> {
  int _height = 170;
  int _weight = 70;
  int _age = 25;
  double _bmi = 0.0;
  String _bmiResult = "";

  void _calculateBMI() {
    setState(() {
      _bmi = (_weight / ((_height / 100) * (_height / 100)));
      if (_bmi < 18.5) {
        _bmiResult = "Underweight";
      } else if (_bmi >= 18.5 && _bmi < 25) {
        _bmiResult = "Normal";
      } else if (_bmi >= 25 && _bmi < 30) {
        _bmiResult = "Overweight";
      } else {
        _bmiResult = "Obesity";
      }
    });
    
    _showResultDialog();
  }

  Future<void> _showInputDialog(String title, int initialValue, ValueChanged<int> onChanged) async {
    TextEditingController controller = TextEditingController(text: initialValue.toString());
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter $title'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter $title',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                int value = int.parse(controller.text);
                onChanged(value);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResultDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Your BMI: ${_bmi.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  _bmiResult,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BMIResultScreen(
                          bmi: _bmi,
                          bmiResult: _bmiResult,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'See Details',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator', style: TextStyle(color: Colors.grey[800])),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'BMI Calculator',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      children: <Widget>[
                        // Height
                        GestureDetector(
                          onTap: () {
                            _showInputDialog('Height (cm)', _height, (value) {
                              setState(() {
                                _height = value;
                              });
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: Colors.blue, width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Height (cm)',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '$_height cm',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Slider(
                          value: _height.toDouble(),
                          min: 110.0,
                          max: 230.0,
                          onChanged: (double value) {
                            setState(() {
                              _height = value.round();
                            });
                          },
                          label: '$_height cm',
                          divisions: 120,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                        ),
                        const SizedBox(height: 16.0),
                        // Weight
                        GestureDetector(
                          onTap: () {
                            _showInputDialog('Weight (kg)', _weight, (value) {
                              setState(() {
                                _weight = value;
                              });
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: Colors.green, width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Weight (kg)',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '$_weight kg',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Slider(
                          value: _weight.toDouble(),
                          min: 30.0,
                          max: 200.0,
                          onChanged: (double value) {
                            setState(() {
                              _weight = value.round();
                            });
                          },
                          label: '$_weight kg',
                          divisions: 170,
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                        ),
                        const SizedBox(height: 16.0),
                        // Age
                        GestureDetector(
                          onTap: () {
                            _showInputDialog('Age (years)', _age, (value) {
                              setState(() {
                                _age = value;
                              });
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: Colors.purple, width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Age (years)',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '$_age years',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Slider(
                          value: _age.toDouble(),
                          min: 10.0,
                          max: 100.0,
                          onChanged: (double value) {
                            setState(() {
                              _age = value.round();
                            });
                          },
                          label: '$_age years',
                          divisions: 90,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                        ),
                        const SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: _calculateBMI,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'Calculate BMI',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class BMIResultScreen extends StatelessWidget {
  final double bmi;
  final String bmiResult;

  const BMIResultScreen({super.key, required this.bmi, required this.bmiResult});

  Color _getColorForBMICategory(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.orange;
      case 'Normal weight':
        return Colors.blue;
      case 'Overweight':
        return Colors.yellow;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 24.9) return 'Normal weight';
    if (bmi < 29.9) return 'Overweight';
    return 'Obese';
  }

  String _getHealthTips(String bmiCategory) {
    switch (bmiCategory) {
      case 'Underweight':
        return 'Consider a balanced diet with more calories. Consult a nutritionist for personalized advice.';
      case 'Normal weight':
        return 'Maintain your healthy weight with regular exercise and a balanced diet.';
      case 'Overweight':
        return 'Adopt a healthy eating plan and increase physical activity to manage weight.';
      case 'Obese':
        return 'Seek guidance from a healthcare provider for a personalized weight loss plan and support.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bmiCategory = _getBMICategory(bmi);
    final healthTips = _getHealthTips(bmiCategory);
    final categoryColor = _getColorForBMICategory(bmiCategory);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Results'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: bmi / 40, // Assuming the maximum BMI value considered is 40
                        strokeWidth: 10.0,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
                      ),
                      Center(
                        child: Text(
                          bmi.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                            color: categoryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'You have $bmiResult body weight!',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'BMI Category: $bmiCategory',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: categoryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Health Tips:',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  healthTips,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                InkWell(
                  borderRadius: BorderRadius.circular(30.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BMIInfoScreen(
                          bmi: bmi,
                          bmiResult: bmiResult,
                        ),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      child: Center(
                        child: Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Recalculate BMI',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class BMIInfoScreen extends StatelessWidget {
  final double bmi;
  final String bmiResult;

  const BMIInfoScreen({super.key, required this.bmi, required this.bmiResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Info'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Increased padding around the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container to center and constrain the width
            Container(
              constraints: const BoxConstraints(maxWidth: 600), // Constraining max width for better appearance
              child: Column(
                children: <Widget>[
                  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Your BMI',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          bmi.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(221, 79, 79, 79),
                          ),
                        ),
                        Text(
                          bmiResult,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  const SizedBox(height: 90.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CategoryRow('18.5 to 24.9', 'Normal'),
                          const Divider(color: Colors.grey),
                          CategoryRow('Less than 18.5', 'Underweight'),
                          const Divider(color: Colors.grey),
                          CategoryRow('25 to 29.9', 'Overweight'),
                          const Divider(color: Colors.grey),
                          CategoryRow('30 and above', 'Obesity'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70.0),
           ElevatedButton(
  onPressed: () {
    // Implement save results functionality

    // Show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Results saved successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.lightBlueAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
  ),
  child: const Text(
  'Save Results',
  style: TextStyle(
    fontSize: 16.0,
    color: Colors.white, // Replace with your desired color code
  ),
)

)
          ],
        ),
      ),
    );
  }
}

class CategoryRow extends StatelessWidget {
  final String range;
  final String label;

  const CategoryRow(this.range, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            range,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}