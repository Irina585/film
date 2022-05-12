import 'package:film/bloc/detail_bloc/detail_bloc.dart';
import 'package:film/bloc/error_bloc/error_bloc.dart';
import 'package:film/bloc/error_bloc/error_event.dart';
import 'package:film/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:film/data/reppositories/films_repositories.dart';
import 'package:film/presentation/pages/catalog_page.dart';
import 'package:film/presentation/pages/film_detail_grid_page.dart';
import 'package:film/presentation/pages/film_detail_tile_page.dart';
import 'package:film/presentation/pages/filter_films_page.dart';
import 'package:film/presentation/pages/main_page.dart';
import 'package:film/presentation/pages/home_page.dart';
import 'package:film/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider<ErrorBloc>(
              lazy: false,
              create: (_) => ErrorBloc(),
              child: RepositoryProvider<FilmsRepository>(
                lazy: true,
                create: (BuildContext context) => FilmsRepository(
                  onErrorHandler: (String code, String message) {
                    context
                        .read<ErrorBloc>()
                        .add(ShowDialogEvent(title: code, message: message));
                  },
                ),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<HomeBloc>(
                      lazy: false,
                      create: (BuildContext context) =>
                          HomeBloc(context.read<FilmsRepository>()),
                      child: const MainPage(),
                    ),
                    BlocProvider<DetailBloc>(
                      lazy: false,
                      create: (BuildContext context) => DetailBloc(),
                      child: const FilmDetailTilePage(),
                    ),
                  ],
                  child: const MainPage(),
                ),
              ),
            ),
        '/catalogPage': (context) => const CatalogPage(),
        '/settings': (context) =>
            const SettingsPage(arguments: SettingsArguments('Ирина')),
        '/filmDetailGridPage': (context) => const FilmDetailGridePage(),
        '/filmDetailTilePage': (context) => const FilmDetailTilePage(),
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
