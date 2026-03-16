import 'package:flutter/material.dart';
import 'package:taskmanager/core/src/colors.dart';


abstract class BaseFormField extends TextFormField {
  BaseFormField({
    super.key,
    super.controller,
    super.onChanged,
    String? label,
    String? error,
  }) : super(
    decoration: AppInputDecoration(
      label: label,
      error: error
    )
  );
}

class AppFormField extends BaseFormField {
  AppFormField.email({
    super.key,
    super.label,
    super.onChanged,
    super.controller,
    super.error,
  });
  AppFormField.password({
    super.key,
    super.label,
    super.onChanged,
    super.controller,
    super.error
  });
}

class AppInputDecoration extends InputDecoration {
  AppInputDecoration({
    String? label,
    String? error,
    super.hint
  }) : super(
    errorText: error,
    labelText: label,
    helperText: ' ', // пробел резервирует место
    errorStyle: TextStyle(height: 1.2),
    helperStyle: TextStyle(height: 1.2),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.grey)
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: colorInputDisable)
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: colorInputFocused)
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.red)
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.red)
    )
  );
}