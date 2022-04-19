import 'package:film/feauters/home/pages/settings_page.dart';
import 'package:film/feauters/home/widgets/film_grid.dart';
import 'package:film/feauters/home/widgets/film_list.dart';
import 'package:flutter/material.dart';

import '../../../strings.dart';

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
