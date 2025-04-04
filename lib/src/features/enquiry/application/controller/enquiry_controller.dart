



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
  List<String> allCountries = [];
  List<String> filteredCountries = [];
  List<MedicalAgencyModel> filteredMedicals = [];
  String? selectedCode;
  MedicalAgencyModel? selectedMedical;
  String? selectedCountry;
  String? countryErrorText;
  String? medicalErrorText;


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