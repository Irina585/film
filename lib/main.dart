import 'package:film/presentation/home/bloc/home_bloc.dart';
import 'package:film/presentation/pages/film_detail_page.dart';
import 'package:film/presentation/pages/tabs/favorite_page.dart';
import 'package:film/presentation/settings/bloc/settings_bloc.dart';
import 'package:film/presentation/settings/bloc/settings_event.dart';
import 'package:film/presentation/settings/settings_page.dart';
import 'package:film/presentation/pages/tabs/catalog_page.dart';
import 'package:film/presentation/pages/filter_films_page.dart';
import 'package:film/presentation/pages/main_page.dart';
import 'package:film/presentation/pages/tabs/home_page.dart';
import 'package:film/presentation/pages/not_found_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/components/locals/locals.dart';
import 'app/error_bloc/error_bloc.dart';
import 'app/error_bloc/error_event.dart';
import 'app/locale_bloc/locale_bloc.dart';
import 'app/locale_bloc/locale_state.dart';
import 'data/repositories/films_repositories.dart';

void main() async {
  /// переинициализация перед инициализацией Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(BlocProvider<LocaleBloc>(
      lazy: false, create: (_) => LocaleBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ErrorBloc>(
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
        child: BlocProvider<HomeBloc>(
          lazy: false,
          create: (BuildContext context) =>
              HomeBloc(context.read<FilmsRepository>()),
          child: BlocProvider<LocaleBloc>(
            lazy: false,
            create: (_) => LocaleBloc(),

            /// сделаем реакцию на изменение состояния,
            /// при которой будут подставляться другие объекты со строками локализации
            child: BlocProvider<SettingBloc>(
              lazy: false,
              create: (_) =>
                  SettingBloc(context.read<LocaleBloc>())..add(LoadNameEvent()),
              child: BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,

                    /// Прокидываем нашу локаль из стейта, а делегат проверяет ее на
                    /// возможность использования в supportedLocales
                    locale: state.locale,
                    localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                      GlobalWidgetsLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      MyLocalizationsDelegate(initialLocals),
                    ],
                    supportedLocales: availableLocales.values,
                    initialRoute: '/',
                    onGenerateRoute: (RouteSettings settings) {
                      if (settings.name == MainPage.routeName) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const MainPage();
                          },
                        );
                      }
                      if (settings.name == CatalogPage.routeName) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const CatalogPage();
                          },
                        );
                      }
                      if (settings.name == FavoritePage.routeName) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const FavoritePage();
                          },
                        );
                      }
                      if (settings.name == HomePage.routeName) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        );
                      }
                      if (settings.name == FilmDetailPage.routeName) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const FilmDetailPage();
                          },
                        );
                      }
                      if (settings.name == SettingsPage.routeName) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const SettingsPage();
                          },
                        );
                      }
                      if (settings.name == FilterFilmsWidget.routeName) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const FilterFilmsWidget();
                          },
                        );
                      }
                      return MaterialPageRoute(
                        builder: (_) => const NoFoundPage(),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
