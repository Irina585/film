import 'package:film/data/repositories/films_repositories.dart';
import 'package:film/presentation/home/bloc/home_bloc.dart';
import 'package:film/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:film/presentation/pages/film_detail_page.dart';
import 'package:film/presentation/pages/tabs/catalog_page.dart';
import 'package:film/presentation/pages/tabs/favorite_page.dart';
import 'package:film/presentation/pages/tabs/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _Tab {
  const _Tab({required this.icon, required this.page, required this.label});

  final Icon icon;
  final String label;
  final Widget page;
}

class MainPage extends StatefulWidget {
  static const String routeName = '/';

  static const List<_Tab> _tabs = <_Tab>[
    _Tab(
        icon: Icon(Icons.local_movies_outlined),
        page: HomePage(),
        label: 'Feed'),
    _Tab(icon: Icon(Icons.movie_filter), page: CatalogPage(), label: 'Catalog'),
    _Tab(icon: Icon(Icons.favorite), page: FavoritePage(), label: 'Favorite'),
  ];

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          lazy: false,
          create: (BuildContext context) => NavigationBloc(),
          child: const FilmDetailPage(),
        ),
      ],
      child: Scaffold(
        body: MainPage._tabs.elementAt(_selectedIndex).page,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: List.generate(MainPage._tabs.length, (index) {
            final _Tab tab = MainPage._tabs[index];
            return BottomNavigationBarItem(icon: tab.icon, label: tab.label);
          }),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
