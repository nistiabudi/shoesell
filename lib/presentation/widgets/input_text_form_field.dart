import 'package:flutter/material.dart';

class InputTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isSecureField;
  final bool autoCorrect;
  final String? hint;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validation;
  final double hintTextSize;
  final bool enable;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  const InputTextFormField(
      {Key? key,
      required this.textEditingController,
      this.autoCorrect = false,
      this.isSecureField = false,
      this.enable = true,
      this.hintTextSize = 14,
      this.contentPadding,
      this.hint,
      this.onFieldSubmitted,
      this.textInputAction,
      this.validation})
      : super(key: key);

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: widget.isSecureField && !_passwordVisible,
      enableSuggestions: !widget.isSecureField,
      autocorrect: widget.autoCorrect,
      validator: widget.validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enable,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: widget.hintTextSize,
        ),
        contentPadding: widget.contentPadding,
        suffixIcon: widget.isSecureField
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none),
      ),
    );
  }
}
