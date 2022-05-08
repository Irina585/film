import 'package:film/domain/models/film_card_model.dart';
import 'package:film/components/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/images.dart';

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

class FilmListWidget extends StatefulWidget {
  static const String routeName = '/filmListWidget';

  const FilmListWidget({Key? key}) : super(key: key);

  @override
  State<FilmListWidget> createState() => _FilmListWidgetState();
}

class _FilmListWidgetState extends State<FilmListWidget> {
  final filmsArray = [
    Comedy('1', 'Красотка', Images.prettyWoman, '9 июля 1990',
        Strings.prettyWomanDescription, 'Английский', 8.0),
    Comedy('2', 'Гарфилд', Images.garfild, '18 ноября 2004',
        Strings.garfildDescription, 'Английский', 6.8),
    Comedy('3', 'Один дома', Images.homeAlone, '17 октября 1990 г.',
        Strings.homeAloneDescription, 'Английский', 8.3),
    Comedy('4', 'Не смотри наверх', Images.dontLookUp, '8 сентября 2021',
        Strings.dontLookUpDescription, 'Английский', 7.5),
    Comedy('5', 'Форест Гамп', Images.forestGump, '18 января 1994',
        Strings.forrestDescription, 'Английский', 8.9),
    Comedy('6', 'Холоп', Images.holop, '25 сентября 2019',
        Strings.holopDescription, 'Русский', 6.8),
  ];

  var filterFilms = <Film>[];

  final _searchController = TextEditingController();

  void _searchFilms() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      filterFilms = filmsArray.where((Film film) {
        return film.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filterFilms = filmsArray;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    filterFilms = filmsArray;
    _searchController.addListener(_searchFilms);
  }

  // переход на описание каждого фильма по id
  void _onFilmTap(int index) {
    final idFilmTap = filmsArray[index].id;
    Navigator.of(context)
        .pushNamed('/filmListWidget/filmDetailsWidget', arguments: idFilmTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.titleApp),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/filterFilmsWidget'),
              icon: const Icon(Icons.filter_alt))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              padding: const EdgeInsets.only(top: 70.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: filterFilms.length,
              itemExtent: 160,
              itemBuilder: (BuildContext context, int index) {
                final film = filterFilms[index]; // элемент с текущим индексом
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2))
                            ]),
                        clipBehavior: Clip.hardEdge,
                        child: Row(
                          children: [
                            Image.asset(film.picture),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 7),
                                  Text(film.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          film.releaseDate,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                      const Icon(Icons.star,
                                          color: Colors.yellow),
                                      const SizedBox(width: 2),
                                      Text(
                                        film.voteAverage.toString(),
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    film.language,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(film.description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          onTap: () => _onFilmTap(index),
                        ),
                      )
                    ],
                  ),
                );
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
          )
        ],
      ),
    );
  }
}