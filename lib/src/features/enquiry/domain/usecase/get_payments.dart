


import 'package:ministry/src/features/enquiry/domain/model/payment_model.dart';

import '../../data/repositories/enquiry_repository.dart';

class GetPaymentList{

  final EnquiryRepository repository;

  GetPaymentList(this.repository);

  Future<List<PaymentListModel>> call({required String code}) {
    return repository.fetchPaymentList(code: code);
  }


}


