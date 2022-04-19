import 'package:film/app/models/film_card_model.dart';
import 'package:film/app/widgets/film_card.dart';
import 'package:film/app/widgets/film_tile.dart';
import 'package:film/feauters/home/widgets/film_list.dart';
import 'package:flutter/material.dart';

import '../../../strings.dart';

class FilmGrid extends StatelessWidget {
  const FilmGrid({Key? key}) : super(key: key);

  static const List<FilmCardModel> _films = <FilmCardModel>[
    FilmCardModel(
        id: 0,
        picture: Strings.prettyWomanLink,
        icon: Icon(Icons.favorite),
        voteAverage: 8.0),
    FilmCardModel(
        id: 1,
        picture: Strings.garfildLink,
        icon: Icon(Icons.favorite),
        voteAverage: 6.8),
    FilmCardModel(
        id: 2,
        picture: Strings.homeAloneLink,
        icon: Icon(Icons.favorite),
        voteAverage: 8.3),
    FilmCardModel(
        id: 3,
        picture: Strings.dontLookUpLink,
        icon: Icon(Icons.favorite),
        voteAverage: 7.5),
    FilmCardModel(
        id: 4,
        picture: Strings.forrestLink,
        icon: Icon(Icons.favorite),
        voteAverage: 8.9),
    FilmCardModel(
        id: 5,
        picture: Strings.holopLink,
        icon: Icon(Icons.favorite),
        voteAverage: 6.8)
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilmCard.fromModel(model: _films[index % _films.length]),
          );
        });
  }
}
