import 'package:flutter/material.dart';

enum ButtonScale { small, medium, large }

//реализоция подстановки нужных стилей для каждого размера через расширение
extension ButtonStyleByScale on ButtonStyle {
  ButtonStyle byScale(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.small:
        return copyWith(
            minimumSize: MaterialStateProperty.all(const Size(75, 30)));
      case ButtonScale.medium:
        return copyWith(
            minimumSize: MaterialStateProperty.all(const Size(78, 36)));
      case ButtonScale.large:
        return copyWith(
          minimumSize: MaterialStateProperty.all(const Size(88, 44)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20)),
        );
    }
  }
}
