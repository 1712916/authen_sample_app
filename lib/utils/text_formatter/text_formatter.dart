import 'package:flutter/services.dart';

class FirstSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String oldText = oldValue.text;
    String newText = newValue.text;
    if (oldText.isEmpty && newText.isNotEmpty && newText[0] == ' ') {
      return oldValue;
    }
    return newValue;
  }
}