import 'package:film/presentation/pages/catalog_page.dart';
import 'package:film/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class _Tab {
  const _Tab({required this.icon, required this.page, required this.label});

  final Icon icon;
  final String label;
  final Widget page;
}

class MainPage extends StatefulWidget {
  static const List<_Tab> _tabs = <_Tab>[
    _Tab(
        icon: Icon(Icons.local_movies_outlined),
        page: MyHomePage(),
        label: 'Feed'),
    _Tab(icon: Icon(Icons.movie_filter), page: CatalogPage(), label: 'Catalog')
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
    return Scaffold(
      body: MainPage._tabs.elementAt(_selectedIndex).page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: List.generate(MainPage._tabs.length, (index) {
          final _Tab tab = MainPage._tabs[index];
          return BottomNavigationBarItem(icon: tab.icon, label: tab.label);
        }),
        onTap: _onItemTapped,
      ),
    );
  }
}
