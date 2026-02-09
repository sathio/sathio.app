import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/app_colors.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: AppRadius.mdRadius,
            border: Border.all(
              color: errorText != null
                  ? context.colorScheme.error
                  : AppColors.gray300,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              // Country Code
              Text(
                '+91',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(width: 1, height: 24, color: AppColors.gray300),
              const SizedBox(width: AppSpacing.sm),
              // Phone Input
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                    _PhoneNumberFormatter(),
                  ],
                  style: context.textTheme.titleLarge?.copyWith(
                    letterSpacing: 1.2,
                  ),
                  decoration: const InputDecoration(
                    hintText: '000-000-0000',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    filled: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.xs,
              left: AppSpacing.xs,
            ),
            child: Text(
              errorText!,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Simple logic to add dashes can be complex with cursor position
    // For now, sticking to simple digits or minimal formatting if needed
    // But request asked for "Format display: XXX-XXX-XXXX"

    // A robust formatter is better, but here is a simple implementation
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) {
        if (i != 0) formatted += '-';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
