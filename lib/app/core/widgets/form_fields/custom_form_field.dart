import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui_helper/color/colors.dart';
import '../../ui_helper/style/font_style.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.obscuringCharacter = '*',
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.inputFormatters,
    this.autovalidateMode,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.expand = false,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.showPasswordToggle = false,
    this.filled = true,
    this.fillColor = const Color(0x14FFFFFF),
    this.focusedFillColor,
    this.disabledFillColor,
    this.borderColor = const Color(0xCCFFFFFF),
    this.focusedBorderColor = AppColors.white,
    this.errorBorderColor = AppColors.error,
    this.disabledBorderColor = const Color(0x4DFFFFFF),
    this.cursorColor = AppColors.white,
    this.iconColor = AppColors.white,
    this.focusedIconColor = AppColors.white,
    this.hintColor = const Color(0xB3FFFFFF),
    this.textColor = AppColors.white,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 18,
    ),
    this.borderRadius = 999,
    this.borderWidth = 1.15,
    this.constraints,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final String? prefixText;
  final String? suffixText;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool expand;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool showPasswordToggle;
  final bool filled;
  final Color fillColor;
  final Color? focusedFillColor;
  final Color? disabledFillColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color disabledBorderColor;
  final Color cursorColor;
  final Color iconColor;
  final Color focusedIconColor;
  final Color hintColor;
  final Color textColor;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final double borderWidth;
  final BoxConstraints? constraints;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured = widget.obscureText;

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPasswordToggle = widget.showPasswordToggle || widget.obscureText;
    final iconTheme = IconThemeData(color: widget.iconColor, size: 22);
    final resolvedFillColor = WidgetStateColor.resolveWith((states) {
      if (!widget.enabled) {
        return widget.disabledFillColor ?? widget.fillColor;
      }
      if (states.contains(WidgetState.focused)) {
        return widget.focusedFillColor ?? widget.fillColor;
      }
      return widget.fillColor;
    });

    return IconTheme(
      data: iconTheme,
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        controller: widget.controller,
        initialValue: widget.initialValue,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        style:
            widget.style ??
            AppStyles.black16Medium.copyWith(
              color: widget.textColor,
              letterSpacing: 0.1,
            ),
        cursorColor: widget.cursorColor,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        onTap: widget.onTap,
        inputFormatters: widget.inputFormatters,
        autovalidateMode: widget.autovalidateMode,
        maxLines: widget.expand
            ? null
            : (widget.obscureText ? 1 : widget.maxLines),
        minLines: widget.expand ? null : widget.minLines,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        expands: widget.expand,
        obscureText: hasPasswordToggle ? _isObscured : widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        enableSuggestions: widget.obscureText
            ? false
            : widget.enableSuggestions,
        autocorrect: widget.obscureText ? false : widget.autocorrect,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: _buildSuffixIcon(hasPasswordToggle),
          prefix: widget.prefix,
          suffix: widget.suffix,
          prefixText: widget.prefixText,
          suffixText: widget.suffixText,
          filled: widget.filled,
          fillColor: resolvedFillColor,
          constraints: widget.constraints,
          contentPadding: widget.contentPadding,
          hintStyle:
              widget.hintStyle ??
              AppStyles.grey16Medium.copyWith(color: widget.hintColor),
          labelStyle:
              widget.labelStyle ??
              theme.inputDecorationTheme.labelStyle?.copyWith(
                color: widget.hintColor,
              ),
          errorStyle: widget.errorStyle ?? AppStyles.red14Normal,
          prefixIconColor: WidgetStateColor.resolveWith((states) {
            return states.contains(WidgetState.focused)
                ? widget.focusedIconColor
                : widget.iconColor;
          }),
          suffixIconColor: WidgetStateColor.resolveWith((states) {
            return states.contains(WidgetState.focused)
                ? widget.focusedIconColor
                : widget.iconColor;
          }),
          enabledBorder: _border(widget.borderColor),
          focusedBorder: _border(widget.focusedBorderColor),
          errorBorder: _border(widget.errorBorderColor),
          focusedErrorBorder: _border(widget.errorBorderColor),
          disabledBorder: _border(widget.disabledBorderColor),
          border: _border(widget.borderColor),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon(bool hasPasswordToggle) {
    if (!hasPasswordToggle) return widget.suffixIcon;

    final iconColor = (widget.focusNode?.hasFocus ?? false)
        ? widget.focusedIconColor
        : widget.iconColor;

    return IconButton(
      onPressed: widget.enabled
          ? () => setState(() => _isObscured = !_isObscured)
          : null,
      splashRadius: 20,
      icon: Icon(
        _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
      color: iconColor,
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: widget.borderWidth),
    );
  }
}
