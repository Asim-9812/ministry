


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