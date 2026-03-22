import 'package:flutter/material.dart';
import 'package:taskmanager/core/utils/enums.dart';
import 'package:taskmanager/core/src/colors.dart';

class ThemeModeState {
  final ETheme theme;

  const ThemeModeState(this.theme);

  Color get colorTextPrimary => _getColorForScheme(
    light: Colors.black,
    dark: Colors.white,
  );

  Color get colorTextSecondary => _getColorForScheme(
    light: Colors.grey[700]!,
    dark: Colors.grey[300]!,
  );

  Color get colorBackgroundPrimary => _getColorForScheme(
    light: Colors.white,
    dark: Colors.black,
  );

  Color get colorButtonPrimary => _getColorForScheme(
    light: colorButtonPrimaryLight,
    dark: colorButtonPrimaryDark,
  );

  Color get colorButtonPrimaryText => _getColorForScheme(
    light: Colors.white,
    dark: Colors.white,
  );

  Color get colorTextLink => _getColorForScheme(
    light: colorTextLinkLight,
    dark: colorTextLinkDark,
  );

  Color _getColorForScheme({
    required Color light,
    required Color dark,
  }) {
    switch (theme) {
      case ETheme.light: return light;
      case ETheme.dark: return dark;
    }
  }
}