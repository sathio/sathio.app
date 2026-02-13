import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/extensions.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Country Code
          Text(
            '+91',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Container(height: 24, width: 1, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          // Input Field
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              keyboardType: TextInputType.number,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
              cursorColor: context.theme.primaryColor,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '000-000-0000',
                hintStyle: TextStyle(color: Colors.grey),
                counterText: '', // Hide length counter
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
                _IndianPhoneFormatter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom formatter for XXX-XXX-XXXX style
class _IndianPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If deleted, return new value as is (logic can be complex, keeping simple)
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    // XXX-XXX-XXXX
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
