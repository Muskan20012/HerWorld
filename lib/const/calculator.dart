import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';

class Calculate {
  Calculate({required this.height, required this.weight});
  final int height;
  final int weight;
  double _bmi = 0;
  Color _textColor = Color(0xFF24D876);
  String result() {
    _bmi = (weight / pow(height / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  String getText() {
    if (_bmi >= 40) {
      return 'Extreme Obesity';
    } else if (_bmi > 35) {
      return 'Obesity (Class 2)';
    } else if (_bmi > 30) {
      return 'Obesity (Class 1)';
    } else if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'UNDERWEIGHT';
    }
  }

  String getAdvise() {
    if (_bmi >= 25) {
      return 'You have a more than normal body weight.\n Try to do more Exercise';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight.\nGood job!';
    } else {
      return 'You have a lower than normal body weight.\n Try to eat more';
    }
  }

  Color getTextColor() {
    if (_bmi >= 25 || _bmi <= 18.5) {
      return Colors.deepOrangeAccent;
    } else {
      return Color(0xFF24D876);
    }
  }
}

class CalculateIn {
  CalculateIn({required this.feet, required this.inches, required this.weight});
  final int feet;
  final int inches;
  final int weight;
  double _bmi = 0;
  Color _textColor = Color(0xFF24D876);
  String result() {
    _bmi = (weight / pow((feet * 30.48 + inches * 2.54) / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  String getText() {
    if (_bmi >= 40) {
      return 'Extreme Obesity';
    } else if (_bmi > 35) {
      return 'Obesity (Class 2)';
    } else if (_bmi > 30) {
      return 'Obesity (Class 1)';
    } else if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'UNDERWEIGHT';
    }
  }

  String getAdvise() {
    if (_bmi >= 25) {
      return 'You have a more than normal body weight.\n Try to do more Exercise';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight.\nGood job!';
    } else {
      return 'You have a lower than normal body weight.\n Try to eat more';
    }
  }

  Color getTextColor() {
    if (_bmi >= 25 || _bmi <= 18.5) {
      return Colors.deepOrangeAccent;
    } else {
      return Color(0xFF24D876);
    }
  }
}
