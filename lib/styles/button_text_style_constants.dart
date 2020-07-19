import 'package:flutter/material.dart';
import 'package:laradart/styles/color_constants.dart';

enum ButtonTextStyle {
  primary,
  secondary,
  accent,
  error,
  success,
}

/// Get the button text style based on [ButtonTextStyle] type given.
///
/// @param [ButtonTextStyle] style
/// @return [TextStyle]
getButtonTextStyle({ButtonTextStyle style}) {
  switch (style) {
    case ButtonTextStyle.primary:
      return TextStyle(
        color: getColor(type: ColorType.primary),
        fontWeight: FontWeight.bold,
      );
    case ButtonTextStyle.secondary:
      return TextStyle(
        color: getColor(type: ColorType.primary),
        fontWeight: FontWeight.bold,
      );
    case ButtonTextStyle.accent:
      return TextStyle(
        color: getColor(type: ColorType.primary),
        fontWeight: FontWeight.bold,
      );
    case ButtonTextStyle.error:
      return TextStyle(
        color: getColor(type: ColorType.primary),
        fontWeight: FontWeight.bold,
      );
    case ButtonTextStyle.success:
      return TextStyle(
        color: getColor(type: ColorType.primary),
        fontWeight: FontWeight.bold,
      );
    default:
      return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );
  }
}
