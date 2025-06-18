


final logoUrl = 'assets/images/ministry-logo.png';

class Api{

  static const baseUrl = 'https://mainapi.hospitalsnepal.com/api/central';

  static const login = '$baseUrl/Member/MemberLogin';

  static const publicNoticeList = '$baseUrl/Notice/PublicList';
  static const healthTipList = '$baseUrl/HealthTips/GetList';
  static const sliderList = '$baseUrl/Sliders/GetList';

  static const getMedicalAgency = '$baseUrl/medicalagency';
  static const getAvailableCountry = '$baseUrl/GlobalDropdown/getDropDownList?DropDownType=applycountry';
  static const getProvince = '$baseUrl/GlobalDropdown/getDropDownList?DropDownType=province';
  // static const getAvailableAgency = '$baseUrl/GlobalDropdown/getDropDownList?DropDownType=FilterByCountry&filter1=';
  static const insertEnquiry = '$baseUrl/Enquiry/Insert';
  static const getEnquiryList = '$baseUrl/GlobalDropdown/genericapi';

  static const getMedicalReport = '$baseUrl/MedicalReport/GetReportForMobileByPatientID?PatientNo=';
  static const getAppointmentSlip = '$baseUrl/Enquiry/GetAppointmentSlip?passportno=';


  static const getAllCountries = 'https://countriesnow.space/api/v0.1/countries/';


}