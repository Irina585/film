import 'package:film/feauters/home/widgets/film_list.dart';
import 'package:flutter/material.dart';

import '../../../strings.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.titleApp),
      ),
      body: const FilmList(),
    );
  }
}
