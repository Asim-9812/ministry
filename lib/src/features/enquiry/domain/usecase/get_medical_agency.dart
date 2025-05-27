



import 'package:ministry/src/features/enquiry/data/repositories/enquiry_repository.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

class GetMedicalAgency{

  final EnquiryRepository repository;

  GetMedicalAgency(this.repository);

  Future<List<MedicalAgencyModel>> call({required int provinceId}) {
    return repository.fetchMedicalAgencies(provinceId: provinceId);
  }

}

class GetMedicalAgencyByCode{

  final EnquiryRepository repository;

  GetMedicalAgencyByCode(this.repository);

  Future<MedicalAgencyModel?> call({required String code}) {
    return repository.fetchMedicalAgenciesByCode(code: code);
  }

}