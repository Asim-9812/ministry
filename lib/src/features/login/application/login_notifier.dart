import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/utils/toaster.dart';

import '../../status_page/domain/model/auth_state.dart';
import '../data/repositories/login_repository_impl.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepositoryImpl loginRepository;

  LoginNotifier(this.loginRepository) : super(LoginState()) {
    _loadSavedUser();
  }

  Future<void> _loadSavedUser() async {
    try {
      final user = await loginRepository.getSavedUser();
      if (user != null) {
        state = state.copyWith(user: user);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> login({required String username,required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await loginRepository.login(username: username, password: password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      Toaster.error(e.toString());
    }
  }

  Future<void> logout() async {
    await loginRepository.logout();
    state = state.copyWith(user: null);
  }
}

final loginNotifierProvider =
StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final repository = LoginRepositoryImpl();
  return LoginNotifier(repository);
});