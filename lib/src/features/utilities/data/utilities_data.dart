


import 'package:ministry/src/features/utilities/domain/model/utilities_model.dart';
import 'package:ministry/src/features/utilities/presentation/ui/widgets/bmi/bmi.dart';
import 'package:ministry/src/features/utilities/presentation/ui/widgets/bmr/bmr.dart';
import 'package:ministry/src/features/utilities/presentation/ui/widgets/edd.dart';

List<UtilitiesModel> utilitiesList = [

  UtilitiesModel(img: 'assets/icons/bmi.png', widget: Bmi(), name: 'BMI', shortDesc: 'A measure of body fat based on height and weight.'),
  UtilitiesModel(img: 'assets/icons/bmr.png', widget: Bmr(), name: 'BMR', shortDesc: 'The calories required to maintain basic body functions at rest.'),
  UtilitiesModel(img: 'assets/icons/edd.png', widget: Edd(), name: 'EDD', shortDesc: 'The predicted date for childbirth.'),

];