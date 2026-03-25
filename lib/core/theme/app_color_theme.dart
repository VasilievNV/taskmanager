import 'package:flutter/material.dart';

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final Color? backgroundPrimary;
  final Color? buttonPrimary;
  final Color? textPrimary;
  final Color? textSecondary;
  final Color? inputDisable;
  final Color? inputFocused;
  final Color? textLink;
  final Color? divider;
  final Color? buttonPrimaryText;

  AppColorTheme({
    this.backgroundPrimary,
    this.buttonPrimary,
    this.textSecondary,
    this.textPrimary,
    this.inputDisable,
    this.inputFocused,
    this.textLink,
    this.divider,
    this.buttonPrimaryText
  });

  @override
  AppColorTheme copyWith({
    Color? backgroundPrimary,
    Color? buttonPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? inputDisable,
    Color? inputFocused,
    Color? textLink,
    Color? divider,
    Color? buttonPrimaryText
  }) => 
    AppColorTheme(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      buttonPrimary:  buttonPrimary ?? this.buttonPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textPrimary ?? this.textSecondary,
      inputDisable: inputDisable ?? this.inputDisable,
      inputFocused: inputFocused ?? this.inputFocused,
      textLink: textLink ?? this.textLink,
      divider: divider ?? this.divider,
      buttonPrimaryText: buttonPrimaryText ?? this.buttonPrimaryText
    );

  @override
  AppColorTheme lerp(ThemeExtension<AppColorTheme>? other, double t) {
    if (other is! AppColorTheme) return this;
    return AppColorTheme(
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t),
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t),
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t),
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t),
      inputDisable: Color.lerp(inputDisable, other.inputDisable, t),
      inputFocused: Color.lerp(inputFocused, other.inputFocused, t),
      textLink: Color.lerp(textLink, other.textLink, t),
      divider: Color.lerp(divider, other.divider, t),
      buttonPrimaryText: Color.lerp(buttonPrimaryText, other.buttonPrimaryText, t)
    );
  }
}

class AppThemes {
  static final light = AppColorTheme(
    textPrimary: Colors.black,
    textSecondary: Colors.grey[700]!,
    backgroundPrimary: Colors.white,
    buttonPrimary: Color(0xff3472c2),
    inputDisable: Color(0xffe9f1f7),
    inputFocused: Color(0xff2483c9),
    textLink: Color(0xff3d84f5),
    divider: Color(0xff9fa0a1),
    buttonPrimaryText: Colors.white
  );

  static final dark = AppColorTheme(
    textPrimary: Colors.white,
    textSecondary: Colors.grey[300]!,
    backgroundPrimary: Color(0xFF121212),
    buttonPrimary: Color(0xff3472c2),
    inputDisable: Color(0xffe9f1f7),
    inputFocused: Color(0xff2483c9),
    textLink: Color(0xff3d84f5),
    divider: Color(0xff9fa0a1),
    buttonPrimaryText: Colors.white
  );
}

class AppInputDecorationTheme {
  static const InputDecorationTheme light = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.grey)
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Color(0xffe9f1f7))
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Color(0xff2483c9))
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.red)
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.red)
    )
  );

  static const InputDecorationTheme dark = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.grey)
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Color(0xffe9f1f7))
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Color(0xff2483c9))
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.red)
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.red)
    )
  );
}