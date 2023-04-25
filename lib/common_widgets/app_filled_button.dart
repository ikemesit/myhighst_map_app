import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/global_states.dart';

class AppFilledButton extends ConsumerWidget {
  final Function submitEventCallback;

  final String label;

  final Icon? icon;

  const AppFilledButton({
    Key? key,
    required this.label,
    required this.submitEventCallback,
    this.icon,
  }) : super(key: key);

  void _onSubmit() {
    Function callbackEvt = submitEventCallback();
    callbackEvt();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(appFilledButtonLoadingStateProvider);
    return ElevatedButton.icon(
      onPressed: _onSubmit,
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      icon: isLoading == true
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : icon ?? const SizedBox.shrink(),
    );
  }
}
