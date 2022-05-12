import 'package:film/bloc/home_bloc/film_grid.dart';
import 'package:film/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../../components/strings.dart';

class CatalogPage extends StatelessWidget {
  static const String routeName = '/catalogPage';

  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.titleApp),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings',
                  arguments: const SettingsArguments('Ирина')),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: const FilmGrid(),
    );
  }
}
