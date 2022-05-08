import 'package:film/presentation/pages/catalog_page.dart';
import 'package:film/presentation/pages/film_detail_page.dart';
import 'package:film/presentation/pages/filter_films_page.dart';
import 'package:film/presentation/main_page.dart';
import 'package:film/presentation/pages/home_page.dart';
import 'package:film/presentation/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/catalogPage': (context) => const CatalogPage(),
        '/settings': (context) =>
            const SettingsPage(arguments: SettingsArguments('Ирина')),
        '/filmDetailPage': (context) => const FilmDetailsPage(),
        '/filterFilmsWidget': (context) => const FilterFilmsWidget(),
        '/homePage': (context) => const MyHomePage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == SettingsPage.routeName) {
          final SettingsArguments arguments =
              settings.arguments as SettingsArguments;
          return MaterialPageRoute(
            builder: (context) {
              return SettingsPage(
                arguments: arguments,
              );
            },
          );
        }
      },
    );
  }
}
