import 'package:film/app/components/const.dart';
import 'package:flutter/material.dart';

import '../../home/film_favorite.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = '/favoritePage';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FilmLocal.favorite),
      ),
      body: const FilmFavorite(),
    );
  }
}
