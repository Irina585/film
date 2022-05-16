import 'package:film/app/components/const.dart';
import 'package:film/presentation/home/film_list.dart';
import 'package:film/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FilmLocal.titleApp),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SettingsPage.routeName),
              icon: const Icon(Icons.settings)),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/filterFilmsWidget'),
            icon: const Icon(Icons.filter_alt),
          )
        ],
      ),
      body: const FilmList(),
    );
  }
}
