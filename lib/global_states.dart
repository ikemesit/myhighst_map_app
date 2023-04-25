import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/models/user.model.dart' as model;

// AppFilledButton States
final appFilledButtonLoadingStateProvider =
    StateNotifierProvider((ref) => AppFilledButtonLoadingStateNotifier());

class AppFilledButtonLoadingStateNotifier extends StateNotifier<bool> {
  AppFilledButtonLoadingStateNotifier() : super(false);

  void toggleState() => state = !state;
}

final currentUserProvider = StateProvider<model.User?>((ref) => null);
