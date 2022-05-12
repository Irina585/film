import 'package:film/bloc/home_bloc/film_list.dart';
import 'package:flutter/material.dart';

import '../../components/strings.dart';

class MyHomePage extends StatelessWidget {
  static const String routeName = '/homePage';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.titleApp),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/filterFilmsWidget'),
              icon: const Icon(Icons.filter_alt))
        ],
      ),
      body: const FilmList(),
    );
  }
}
