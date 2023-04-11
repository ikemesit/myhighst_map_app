import 'package:hooks_riverpod/hooks_riverpod.dart';

final emailInputProvider = StateProvider<String?>((ref) => null);
final passwordInputProvider = StateProvider<String?>((ref) => null);
final loginFormSubmittedProvider = StateProvider<bool>((ref) => false);
