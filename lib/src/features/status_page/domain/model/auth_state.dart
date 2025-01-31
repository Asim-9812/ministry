
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_model.dart';

class LoginState {
  final bool isLoading;
  final UserModel? user;
  final String? error;

  LoginState({
    this.isLoading = false,
    this.user,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    UserModel? user,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
