




class BmiCalculator{


  static double calculateBmi({
    required double weight,
    required double heightInCm,
  }) {
    // Convert height from cm to meters
    double heightInMeters = heightInCm / 100;

    // Calculate BMI using the formula
    double bmi = weight / (heightInMeters * heightInMeters);
    return double.parse(bmi.toStringAsFixed(1));
  }

}