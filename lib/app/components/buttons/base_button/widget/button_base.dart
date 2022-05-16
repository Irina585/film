import 'package:flutter/material.dart';

import '../scale_button.dart';
import '../theme_button.dart';
import '../type_button.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.type,
    this.onPressed,
    required this.scale,
    this.style,
    this.child,
  }) : super(key: key);

  final ButtonType type;
  final void Function()? onPressed;
  final ButtonScale scale;
  final ButtonStyle? style;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        baseButtonStyle.byType(type, blueButtonThemeData).byScale(scale);
    return ElevatedButton(
      style: style != null ? style!.merge(defaultStyle) : defaultStyle,
      onPressed: onPressed,
      child: child,
    );
  }
}
