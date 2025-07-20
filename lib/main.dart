import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kids Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _display = '0';
  double? _firstOperand;
  String _operator = '';
  bool _shouldClear = false;

  void _onDigit(String digit) {
    setState(() {
      if (_shouldClear || _display == '0') {
        _display = digit;
        _shouldClear = false;
      } else {
        _display += digit;
      }
    });
  }

  void _onOperator(String op) {
    _firstOperand = double.tryParse(_display);
    _operator = op;
    _shouldClear = true;
  }
  void _calculate() {
    if (_firstOperand == null || _operator.isEmpty) return;
    final secondOperand = double.tryParse(_display) ?? 0;
    double result = 0;
    switch (_operator) {
      case '+':
        result = (_firstOperand ?? 0) + secondOperand;
        break;
      case '-':
        result = (_firstOperand ?? 0) - secondOperand;
        break;
      case '×':
        result = (_firstOperand ?? 0) * secondOperand;
        break;
      case '÷':
        result = secondOperand == 0 ? 0 : (_firstOperand ?? 0) / secondOperand;
        break;
    }
    String formatted;
    if (result.truncateToDouble() == result) {
      formatted = result.toInt().toString();
    } else {
      formatted = result
          .toString()
          .replaceAll(RegExp(r'0+$'), '')
          .replaceAll('.', ',');
    }
    setState(() {
      _display = formatted;
      _firstOperand = null;
      _operator = '';
      _shouldClear = true;
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = null;
      _operator = '';
      _shouldClear = false;
    });
  }

  Widget _buildButton(String text,
      {Color? color, required VoidCallback onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blue.shade100,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: onPressed,
          child: Text(text, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Text(
                _display,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7', onPressed: () => _onDigit('7')),
                  _buildButton('8', onPressed: () => _onDigit('8')),
                  _buildButton('9', onPressed: () => _onDigit('9')),
                  _buildButton('÷',
                      color: Colors.orange.shade200,
                      onPressed: () => _onOperator('÷')),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', onPressed: () => _onDigit('4')),
                  _buildButton('5', onPressed: () => _onDigit('5')),
                  _buildButton('6', onPressed: () => _onDigit('6')),
                  _buildButton('×',
                      color: Colors.orange.shade200,
                      onPressed: () => _onOperator('×')),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', onPressed: () => _onDigit('1')),
                  _buildButton('2', onPressed: () => _onDigit('2')),
                  _buildButton('3', onPressed: () => _onDigit('3')),
                  _buildButton('-',
                      color: Colors.orange.shade200,
                      onPressed: () => _onOperator('-')),
                ],
              ),
              Row(
                children: [
                  _buildButton('0', onPressed: () => _onDigit('0')),
                  _buildButton('C',
                      color: Colors.red.shade200, onPressed: _clear),
                  _buildButton('=',
                      color: Colors.green.shade200, onPressed: _calculate),
                  _buildButton('+',
                      color: Colors.orange.shade200,
                      onPressed: () => _onOperator('+')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
