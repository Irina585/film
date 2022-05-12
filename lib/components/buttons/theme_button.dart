import 'package:film/components/buttons/colors_buttons.dart';
import 'package:film/components/buttons/custom_button_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final baseButtonStyle = TextButton.styleFrom(
  minimumSize: const Size(92, 48),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  textStyle: const TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  ),
);

final blueButtonThemeData = CustomButtonThemeData.fromColors(
    primary: ColorsButtons.blue,
    inverse: ColorsButtons.white,
    secondary: ColorsButtons.secondary,
    error: ColorsButtons.error,
    disabledBackground: ColorsButtons.disabledBackground,
    disabledForeground: ColorsButtons.disabledForeground);
