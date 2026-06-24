import 'package:flutter/material.dart';

import 'era_widget.dart';

enum EraTextFieldVariant {
  filled,
  outlined,
  transparent,
}

class EraTextField extends EraWidget {
  const EraTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.leading,
    this.trailing,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.variant = EraTextFieldVariant.filled,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.obscureText = false,
    this.autofocus = false,
  });

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final String? label;

  final String? hint;

  final Widget? leading;

  final Widget? trailing;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final EraTextFieldVariant variant;

  final int maxLines;

  final int? minLines;

  final bool enabled;

  final bool obscureText;

  final bool autofocus;

  @override
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  ) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: leading,
        suffixIcon: trailing,
        filled:
            variant == EraTextFieldVariant.filled,
        fillColor: switch (variant) {
          EraTextFieldVariant.filled =>
            design.colors.surfaceVariant,
          EraTextFieldVariant.outlined =>
            Colors.transparent,
          EraTextFieldVariant.transparent =>
            Colors.transparent,
        },
        border: OutlineInputBorder(
          borderRadius: design.radius.md,
          borderSide: BorderSide(
            color: design.colors.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: design.radius.md,
          borderSide: BorderSide(
            color: design.colors.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: design.radius.md,
          borderSide: BorderSide(
            color: design.colors.primary,
            width: 2,
          ),
        ),
        contentPadding:
            design.spacing.inputPadding,
      ),
    );
  }
}