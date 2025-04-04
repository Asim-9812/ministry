

class LoadState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  LoadState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  LoadState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return LoadState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}
