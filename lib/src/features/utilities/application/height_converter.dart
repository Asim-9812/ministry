


(String, int, int) convertCmToFeetAndInches(double cm) {
  final int totalInches = (cm * 0.393701).round();
  final int feet = totalInches ~/ 12;
  final int inches = totalInches % 12;
  return ('$feet\'$inches"', feet, inches);
}