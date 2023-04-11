import 'package:hooks_riverpod/hooks_riverpod.dart';

// AppFilledButton States
final appFilledButtonLoadingStateProvider =
    StateNotifierProvider((ref) => AppFilledButtonLoadingStateNotifier());

class AppFilledButtonLoadingStateNotifier extends StateNotifier<bool> {
  AppFilledButtonLoadingStateNotifier() : super(false);

  void toggleState() => state = !state;
}
