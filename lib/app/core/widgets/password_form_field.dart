import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.controller,
    required this.enabled,
    required this.hintText,
    required this.validator,
  });

  final TextEditingController controller;
  final bool enabled;
  final String hintText;
  final String? Function(String?) validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(
            start: mq.size.width * 0.04,
            end: mq.size.width * 0.025,
          ),
          child: const Icon(Icons.lock_outline_rounded),
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
