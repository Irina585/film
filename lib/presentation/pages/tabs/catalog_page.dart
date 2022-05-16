import 'package:film/app/components/const.dart';
import 'package:film/presentation/home/film_grid.dart';
import 'package:film/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  static const String routeName = '/catalogPage';

  const CatalogPage({Key? key}) : super(key: key);

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
        ],
      ),
      body: const FilmGrid(),
    );
  }
}
