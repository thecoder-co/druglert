import 'package:flutter/material.dart';

class CustomTextStyle {}

extension TextStyleExtensions on TextStyle {
  /// w700
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// w600
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);

  /// w400
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// w500
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// With color
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  /// With size
  TextStyle withSize(double size) {
    return copyWith(fontSize: size);
  }

  /// With weight
  TextStyle withWeight(FontWeight weight) {
    return copyWith(fontWeight: weight);
  }
}
