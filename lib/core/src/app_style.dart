import 'package:flutter/material.dart';

class AppStyle extends TextStyle {
  const AppStyle.bold({
    super.fontSize,
    super.color,
  }) : super(
    fontWeight: FontWeight.w700,
  );

  const AppStyle.normal({
    super.fontSize,
    super.color,
    super.decoration
  }) : super(
    fontWeight: FontWeight.normal,
  );

  const AppStyle.medium({
    super.fontSize,
    super.color,
    super.decoration,
  }) : super(
    fontWeight: FontWeight.w500,
  );
}