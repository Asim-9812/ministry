class BmrCalculator {

  static double calculateBmr({
    required int genderIndex, // 0 for male, 1 for female
    required double weight, // Weight in kg
    required double height, // Height in cm
    required int age, // Age in years
  }) {
    if (genderIndex == 0) {
      // Male formula
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else if (genderIndex == 1) {
      // Female formula
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    } else {
      throw ArgumentError("Invalid genderIndex: Use 0 for male and 1 for female.");
    }
  }

}