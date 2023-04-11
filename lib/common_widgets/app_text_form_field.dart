import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.hintText,
    this.validatorFunc,
    this.onChangedFunc,
    this.labelText,
  }) : super(key: key);

  final String? Function(String?)? validatorFunc;
  final bool submitted = false;
  final void Function(String)? onChangedFunc;
  final String? hintText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorFunc,
      autovalidateMode: submitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        hintText: hintText,
        labelText: labelText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusColor: Colors.transparent,
      ),
      onChanged: onChangedFunc,
    );
  }
}
