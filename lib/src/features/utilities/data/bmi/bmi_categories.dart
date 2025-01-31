import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';

import '../../domain/model/bmi_models.dart';

final List<BmiContainer> bmiCategories = [
  BmiContainer(
    label: "Severely Underweight",
    min: 0,
    max: 15.9,
    activeColor: Colors.blue,
    inactiveColor: Colors.grey.shade300, // Light grey
    flex: 1,
    desc: "Very low body weight, high risk of health issues.",
  ),
  BmiContainer(
    label: "Underweight",
    min: 16,
    max: 18.4,
    activeColor: Colors.cyan,
    inactiveColor: Colors.grey.shade400, // Medium-light grey
    flex: 2,
    desc: "Below healthy weight, may need to gain weight.",
  ),
  BmiContainer(
    label: "Normal",
    min: 18.5,
    max: 24.9,
    activeColor: Colors.green,
    inactiveColor: Colors.grey.shade500, // Medium grey
    flex: 4,
    desc: "Healthy weight range, maintain current lifestyle.",
  ),
  BmiContainer(
    label: "Overweight",
    min: 25,
    max: 29.9,
    activeColor: Colors.yellow,
    inactiveColor: Colors.grey.shade600, // Medium-dark grey
    flex: 3,
    desc: "Above healthy weight, increased health risks.",
  ),
  BmiContainer(
    label: "Obese Class I",
    min: 30,
    max: 34.9,
    activeColor: Colors.orange,
    inactiveColor: Colors.grey.shade700, // Dark grey
    flex: 3,
    desc: "Moderately obese, high risk of health complications.",
  ),
  BmiContainer(
    label: "Obese Class II",
    min: 35,
    max: 39.9,
    activeColor: Colors.pink,
    inactiveColor: Colors.grey.shade800, // Very dark grey
    flex: 2,
    desc: "Severely obese, higher risk of severe health issues.",
  ),
  BmiContainer(
    label: "Obese Class III",
    min: 40,
    max: 49.9,
    activeColor: Colors.purple,
    inactiveColor: Colors.grey.shade900, // Almost black grey
    flex: 2,
    desc: "Very high risk of critical health conditions.",
  ),
  BmiContainer(
    label: "Super Obesity",
    min: 50,
    max: double.infinity,
    activeColor: Colors.red,
    inactiveColor: MyColors.black, // Deep grey
    flex: 1,
    desc: "Extremely high body weight, critical health risks.",
  ),
];
