class LoadState {
  final String errorMessage;
  final bool isSuccess;
  final bool isLoad;
  LoadState({
    required this.errorMessage,
    required this.isLoad,
    required this.isSuccess,
  });
  LoadState copyWith({
    String? errorMessage,
    bool? isLoad,
    bool? isSuccess,
  }) {
    return LoadState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoad: isLoad ?? this.isLoad,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
  factory LoadState.empty() {
    return LoadState(
      errorMessage: '',
      isLoad: false,
      isSuccess: false,
    );
  }
}