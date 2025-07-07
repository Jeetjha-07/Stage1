import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // Controllers for text fields
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  
  // Variables to store state
  String _selectedOperation = '+';
  String _result = '';
  bool _hasError = false;

  // List of operations
  final List<String> _operations = ['+', '-', '×', '÷'];

  // Calculate function
  void _calculate() {
    setState(() {
      // Parse input numbers
      double? firstNumber = double.tryParse(_firstNumberController.text);
      double? secondNumber = double.tryParse(_secondNumberController.text);

      // Validate inputs
      if (firstNumber == null || secondNumber == null) {
        _result = 'Please enter valid numbers';
        _hasError = true;
        return;
      }

      // Perform calculation
      double calculationResult;
      
      switch (_selectedOperation) {
        case '+':
          calculationResult = firstNumber + secondNumber;
          break;
        case '-':
          calculationResult = firstNumber - secondNumber;
          break;
        case '×':
          calculationResult = firstNumber * secondNumber;
          break;
        case '÷':
          if (secondNumber == 0) {
            _result = 'Cannot divide by zero';
            _hasError = true;
            return;
          }
          calculationResult = firstNumber / secondNumber;
          break;
        default:
          _result = 'Invalid operation';
          _hasError = true;
          return;
      }

      // Format result (remove unnecessary decimal places)
      if (calculationResult == calculationResult.toInt()) {
        _result = calculationResult.toInt().toString();
      } else {
        _result = calculationResult.toStringAsFixed(2);
      }
      
      _hasError = false;
    });
  }

  // Clear function
  void _clear() {
    setState(() {
      _firstNumberController.clear();
      _secondNumberController.clear();
      _selectedOperation = '+';
      _result = '';
      _hasError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Calculator',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade300,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                // Calculator Icon
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.calculate,
                      size: 30,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // First Number Input
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First Number',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: 6),
                        TextField(
                          controller: _firstNumberController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Enter first number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                            ),
                            prefixIcon: Icon(Icons.looks_one, color: Colors.blue.shade700),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Operation Selection
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Operation',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _operations.map((operation) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedOperation = operation;
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _selectedOperation == operation
                                      ? Colors.blue.shade700
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.blue.shade700,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    operation,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _selectedOperation == operation
                                          ? Colors.white
                                          : Colors.blue.shade700,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Second Number Input
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Second Number',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: 6),
                        TextField(
                          controller: _secondNumberController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Enter second number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                            ),
                            prefixIcon: Icon(Icons.looks_two, color: Colors.blue.shade700),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Calculate and Clear Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _calculate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calculate, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'Calculate',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clear,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.clear, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 20),
                
                // Result Display
                if (_result.isNotEmpty)
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _hasError ? Colors.red.shade50 : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _hasError ? Colors.red.shade300 : Colors.green.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _hasError ? Icons.error : Icons.check_circle,
                            size: 28,
                            color: _hasError ? Colors.red.shade700 : Colors.green.shade700,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Result',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _hasError ? Colors.red.shade700 : Colors.green.shade700,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            _result,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: _hasError ? Colors.red.shade700 : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // Add some bottom padding for better scrolling
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }
}
