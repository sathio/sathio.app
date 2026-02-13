import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/extensions.dart';

class OtpInput extends StatefulWidget {
  final Function(String) onCompleted;

  const OtpInput({super.key, required this.onCompleted});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  // 6 controllers and nodes
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last digit, unfocus and submit
        _focusNodes[index].unfocus();
        _checkCompletion();
      }
    } else {
      // Empty (backspace handled in onKeyEvent primarily, but safety here)
      // handled by OnKeyEvent mostly for consistent backspace behavior across boxes
    }
    _checkCompletion();
  }

  void _checkCompletion() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == 6) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 48,
          height: 56,
          child: KeyboardListener(
            focusNode: FocusNode(), // Dummy node to capture raw keys?
            // Actually TextField handles keys well usually,
            // but for backspace on empty field we might need RawKeyboardListener.
            // keeping simple for now: standard auto-focus flow.
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace &&
                  _controllers[index].text.isEmpty &&
                  index > 0) {
                // Move back on backspace if empty
                _focusNodes[index - 1].requestFocus();
              }
            },
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: context.theme.primaryColor,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (val) => _onDigitChanged(val, index),
            ),
          ),
        );
      }),
    );
  }
}
