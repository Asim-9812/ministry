


import 'package:flutter/material.dart';

class BmiContainer{
  final double max;
  final double min;
  final Color activeColor;
  final Color inactiveColor;
  final String label;
  final int flex;
  final String desc;

  BmiContainer({
    required this.activeColor,
    required this.inactiveColor,
    required this.label,
    required this.max,
    required this.min,
    required this.flex,
    required this.desc
});

}