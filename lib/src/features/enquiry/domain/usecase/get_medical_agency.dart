



import 'package:ministry/src/features/enquiry/data/repositories/enquiry_repository.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

class GetMedicalAgency{

  final EnquiryRepository repository;

  GetMedicalAgency(this.repository);

  Future<List<MedicalAgencyModel>> call({required int provinceId}) {
    return repository.fetchMedicalAgencies(provinceId: provinceId);
  }

}