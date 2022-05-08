import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;

  const PrimaryButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ColoredBox(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white, fontSize: 20)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
