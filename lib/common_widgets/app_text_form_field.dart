import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validatorFunc,
    this.onChangedFunc,
    this.labelText,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validatorFunc;
  final bool submitted = false;
  final void Function(String)? onChangedFunc;
  final String? hintText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validatorFunc,
      autovalidateMode: submitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      onChanged: onChangedFunc,
    );
  }
}
