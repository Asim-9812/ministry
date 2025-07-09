


import '../../data/repositories/enquiry_repository.dart';

class GetCountries{

  final EnquiryRepository repository;

  GetCountries(this.repository);

  Future<List<String>> call() {
    return repository.fetchCountriesList();
  }


}





class GetAvailableCountries{

  final EnquiryRepository repository;

  GetAvailableCountries(this.repository);

  Future<List<dynamic>> call() {
    return repository.fetchAvailableCountriesList();
  }


}


class GetProvinces{

  final EnquiryRepository repository;

  GetProvinces(this.repository);

  Future<List<dynamic>> call() {
    return repository.fetchProvinces();
  }


}

class GetSectors{

  final EnquiryRepository repository;

  GetSectors(this.repository);

  Future<List<dynamic>> call() {
    return repository.fetchSectors();
  }


}


class GetDistricts{

  final EnquiryRepository repository;

  GetDistricts(this.repository);

  Future<List<dynamic>> call({required int? provinceId}) {
    return repository.fetchDistricts(provinceId: provinceId);
  }


}