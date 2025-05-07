



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';



final enquiryController = ChangeNotifierProvider.autoDispose((ref)=>EnquiryController());


class EnquiryController extends ChangeNotifier{

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  int countryId = 0;
  List<String> allCountries = [];
  List<String> filteredCountries = [];
  List<MedicalAgencyModel> filteredMedicals = [];
  String? selectedCode;
  MedicalAgencyModel? selectedMedical;
  String? selectedCountry;
  dynamic selectedCountryDynamic;
  String? countryErrorText;
  String? medicalErrorText;


  void selectDate(DateTime time){
    selectedDate = time;
    notifyListeners();
  }


  void selectAvailableCountry(dynamic country){
    selectedCountryDynamic = country;
    notifyListeners();
  }

  void selectCountry(String? country){
    selectedCountry = country;
    notifyListeners();
  }

  void selectMedicalAgency(MedicalAgencyModel? medicalAgency){
    selectedMedical = medicalAgency;
    selectedCode = medicalAgency?.code;
    notifyListeners();
  }


}