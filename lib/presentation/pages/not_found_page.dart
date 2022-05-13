import 'package:film/components/strings.dart';
import 'package:flutter/material.dart';

class NoFoundPage extends StatelessWidget {
  static const String routeName = '/noFoundPage';

  const NoFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.titleApp),
      ),
      body: const Text('Ничего'),
    );
  }
}
