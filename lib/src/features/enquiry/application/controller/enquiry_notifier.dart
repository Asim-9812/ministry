




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/enquiry/data/repositories/enquiry_repository_impl.dart';
import '../../../../core/models/load_state.dart';
import '../../data/repositories/enquiry_repository.dart';




class EnquiryNotifier extends StateNotifier<LoadState> {
  final EnquiryRepository enquiryRepository;

  EnquiryNotifier({required this.enquiryRepository}) : super(LoadState());


  Future<void> insertEnquiry({required Map<String, dynamic> data}) async {
    state = LoadState(isLoading: true);  // Set loading state

    try {
      bool result = await enquiryRepository.insertEnquiry(data: data);
      if (result) {
        state = LoadState(isLoading: false, isSuccess: true);  // Success state
        Toaster.success('Enquiry submitted.');
      } else {
        state = LoadState(isLoading: false, error: 'Unable to submit enquiry.');  // Error state
        Toaster.error('Unable to submit enquiry.');
      }
    } catch (error) {
      state = LoadState(isLoading: false, error: error.toString());  // Handle exception
      Toaster.error(error.toString());
    }
  }


}


final enquiryNotifier = StateNotifierProvider<EnquiryNotifier, LoadState>((ref) {
  final enquiryRepository = EnquiryRepositoryImpl();  // Provide an instance of the repository
  return EnquiryNotifier(enquiryRepository: enquiryRepository);
});
