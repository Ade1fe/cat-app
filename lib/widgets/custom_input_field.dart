import 'package:cat_shop/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool isPasswordField;
  final bool obscureText;
  final VoidCallback? togglePasswordVisibility;
  final Widget? suffixIcon;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.isPasswordField = false,
    this.obscureText = true,
    this.togglePasswordVisibility,
    this.suffixIcon,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  InputDecoration _inputDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return InputDecoration(
      prefixIcon: Icon(widget.prefixIcon, color: theme.iconTheme.color),
      suffixIcon: widget.suffixIcon ??
          (widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: theme.iconTheme.color,
                  ),
                  onPressed: widget.togglePasswordVisibility,
                )
              : null),
      hintText: widget.hintText,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
      filled: true,
      fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeClass.mainColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? widget.obscureText : false,
      decoration: _inputDecoration(context),
      cursorColor: ThemeClass.mainColor,
      validator: widget.validator,
    );
  }
}
