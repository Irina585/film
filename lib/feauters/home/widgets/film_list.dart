import 'package:film/app/models/film_card_model.dart';
import 'package:film/app/widgets/film_tile.dart';
import 'package:flutter/material.dart';

import '../../../images.dart';
import '../../../images.dart';
import '../../../strings.dart';

enum Language { russian, english }

abstract class Film {
  final String id;
  final String title;
  final String picture;
  final String releaseDate;
  final String description;
  final String language;
  final double voteAverage;

  Film(this.id, this.title, this.picture, this.releaseDate, this.description,
      this.language, this.voteAverage);
}

class Comedy extends Film {
  Comedy(String id, String title, String picture, String releaseDate,
      String description, String language, double voteAverage)
      : super(id, title, picture, releaseDate, description, language,
            voteAverage);
}

// Список фильмов. Параметры заданы в соответствии с моделью FilmCardModel, UI в виде карточки фильма FilmTile

class FilmList extends StatefulWidget {
  const FilmList({Key? key}) : super(key: key);

  static const List<FilmCardModel> films = <FilmCardModel>[
    FilmCardModel(
        id: 0,
        title: 'Красотка',
        voteAverage: 8.0,
        picture: Strings.prettyWomanLink,
        releaseDate: '9 июля 1990',
        description: Strings.prettyWomanDescription,
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 1,
        title: 'Гарфилд',
        voteAverage: 6.8,
        picture: Strings.garfildLink,
        releaseDate: '18 ноября 2004',
        description: Strings.garfildDescription,
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 2,
        title: 'Один дома',
        voteAverage: 8.3,
        picture: Strings.homeAloneLink,
        releaseDate: '17 октября 1990',
        description: Strings.homeAloneDescription,
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 3,
        title: 'Не смотри наверх',
        voteAverage: 7.5,
        picture: Strings.dontLookUpLink,
        releaseDate: '8 сентября 2021',
        description: Strings.dontLookUpDescription,
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 4,
        title: 'Форест Гамп',
        voteAverage: 8.9,
        picture: Strings.forrestLink,
        releaseDate: '18 января 1994',
        description: Strings.forrestDescription,
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 5,
        title: 'Холоп',
        voteAverage: 6.8,
        picture: Strings.holopLink,
        releaseDate: '25 сентября 2019',
        description: Strings.holopDescription,
        icon: Icon(Icons.favorite))
  ];

  @override
  State<FilmList> createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  // создаём новый список для отфильтрованных данных
  var filterFilms = <FilmCardModel>[];

  final _searchController = TextEditingController();

  void _searchFilms() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      filterFilms = FilmList.films.where((element) {
        return element.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filterFilms = FilmList.films;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    filterFilms = FilmList.films;
    _searchController.addListener(_searchFilms);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 70.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (BuildContext context, int index) {
              return FilmTile.fromModel(
                  model: filterFilms[index % filterFilms.length]);
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withAlpha(230),
                border: const OutlineInputBorder(),
                labelText: Strings.searchFilm,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                )),
          ),
        ),
      ],
    );
  }
}
