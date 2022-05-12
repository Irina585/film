import 'package:flutter/material.dart';

//изменяемые атрибуты стилей кнопки
class CustomButtonStyle {
  const CustomButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.side,
    this.disabledSide,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final BorderSide? side;
  final BorderSide? disabledSide;
}

//описание полей, совпадающих по названию с типами кнопок
class CustomButtonThemeData {
  CustomButtonThemeData({
    required this.primary,
    required this.secondary,
    required this.outlined,
    required this.error,
  });

  final CustomButtonStyle primary;
  final CustomButtonStyle secondary;
  final CustomButtonStyle outlined;
  final CustomButtonStyle error;

  factory CustomButtonThemeData.fromColors({
    required Color primary,
    required Color inverse,
    required Color secondary,
    required Color error,
    required Color disabledBackground,
    required Color disabledForeground,
  }) {
    return CustomButtonThemeData(
      primary: CustomButtonStyle(
        backgroundColor: primary,
        foregroundColor: inverse,
        disabledBackgroundColor: disabledBackground,
        disabledForegroundColor: disabledForeground,
      ),
      secondary: CustomButtonStyle(
        backgroundColor: secondary,
        foregroundColor: primary,
        disabledBackgroundColor: disabledBackground,
        disabledForegroundColor: disabledForeground,
      ),
      outlined: CustomButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: primary,
        disabledForegroundColor: disabledForeground,
        side: BorderSide(
          color: primary,
          width: 2,
        ),
        disabledSide: BorderSide(
          color: disabledBackground,
          width: 2,
        ),
      ),
      error: CustomButtonStyle(
        backgroundColor: error,
        foregroundColor: inverse,
        disabledBackgroundColor: disabledBackground,
        disabledForegroundColor: disabledForeground,
      ),
    );
  }
}
