



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';
import 'package:ministry/src/features/enquiry/domain/model/payment_model.dart';



final enquiryController = ChangeNotifierProvider.autoDispose((ref)=>EnquiryController());


class EnquiryController extends ChangeNotifier{

  TextEditingController passController = TextEditingController(); // for enquiryList

  final formKey = GlobalKey<FormState>();
  TextEditingController passportController = TextEditingController();
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
  dynamic selectedProvince;
  dynamic selectedSector;
  dynamic selectedDistrict;
  String? countryErrorText;
  String? provinceErrorText;
  String? medicalErrorText;


  bool isPaying = false;
  PaymentModel? selectedPayment;
  PaymentListModel? selectedPaymentMethod;

  void paymentLoading(bool value){
    isPaying = value;
    notifyListeners();
  }


  void selectPayment(PaymentModel value){
    selectedPayment = value;
    notifyListeners();
  }

  void selectPaymentMethod(PaymentListModel value){
    selectedPaymentMethod = value;
    notifyListeners();
  }


  void selectDate(DateTime time){
    selectedDate = time;
    notifyListeners();
  }

  void selectProvince(dynamic province){
    selectedProvince = province;
    notifyListeners();
  }

  void selectSector(dynamic province){
    selectedSector = province;
    notifyListeners();
  }

  void selectDistrict(dynamic district){
    selectedDistrict = district;
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