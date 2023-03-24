import 'package:flutter/material.dart';

class AppFilledButton extends StatefulWidget {
  final Function submitEventCallback;

  final String label;

  final Icon icon;

  const AppFilledButton({
    Key? key,
    required this.label,
    required this.submitEventCallback,
    required this.icon,
  }) : super(key: key);

  @override
  State<AppFilledButton> createState() => _AppFilledButtonState();
}

class _AppFilledButtonState extends State<AppFilledButton> {
  var _isLoading = false;

  void _onSubmit() {
    Function callbackEvt = widget.submitEventCallback();

    callbackEvt();

    setState(() => _isLoading = true);

    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
      ),
      onPressed: _onSubmit,
      label: Text(
        widget.label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      icon: _isLoading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : widget.icon,
    );
  }
}
