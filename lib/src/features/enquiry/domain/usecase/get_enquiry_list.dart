



import 'package:ministry/src/features/enquiry/data/repositories/enquiry_repository.dart';
import 'package:ministry/src/features/enquiry/domain/model/enquiry_model.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

class GetEnquiryList{

  final EnquiryRepository repository;

  GetEnquiryList(this.repository);

  Future<List<EnquiryModel>> call({required String userId, required String passportNo, required int filter}) {
    return repository.enquiryList(userId: userId, passportNo: passportNo, filter: filter);
  }

}

// class GetEnquiryReport{
//
//   final EnquiryRepository repository;
//
//   GetEnquiryReport(this.repository);
//
//   Future<String?> call({required String passportNo}) {
//     return repository.getEnquiryReport(passportNo: passportNo);
//   }
//
// }