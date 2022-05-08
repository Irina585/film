import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? error;

  const ErrorDialog(
    this.error, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(36),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CloseButton(
                    color: Colors.white,
                  ),
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                      //'${FilmLocal.error}${error.FilmLocal.unknown}',
                      'Ошибка')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Функция вызова диалога ошибки
void showErrorDialog(BuildContext context, {required String error}) {
  showDialog(context: context, builder: (_) => ErrorDialog(error));
}
