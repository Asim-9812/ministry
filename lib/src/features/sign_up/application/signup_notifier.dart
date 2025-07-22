



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/models/load_state.dart';
import 'package:ministry/src/core/utils/toaster.dart';

import '../data/repositories/signup_repository_impl.dart';

class SignupNotifier extends StateNotifier<LoadState>{

  final SignupRepositoryImpl signupRepository;


  SignupNotifier(this.signupRepository) : super(LoadState());

  Future<bool> signUp({required Map<String, dynamic> data}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await signupRepository.signUp(data: data);
      state = state.copyWith(isLoading: false);
      return response;
    }
    catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      Toaster.error('$e');
      return false;
    }
  }

}


final signupNotifierProvider =
StateNotifierProvider<SignupNotifier, LoadState>((ref) {
  final repository = SignupRepositoryImpl();
  return SignupNotifier(repository);
});