import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'film_list_widget.dart';
import '../../components/strings.dart';

class FilmDetailsWidget extends StatelessWidget {
  final String idFilmTap;
  final String title;
  final String picture;
  final String releaseDate;
  final String description;
  final String language;
  final double voteAverage;

  static const String routeName = '/filmListWidget/filmDetailsWidget';

  const FilmDetailsWidget(
      {Key? key,
      required this.idFilmTap,
      required this.title,
      required this.picture,
      required this.releaseDate,
      required this.description,
      required this.language,
      required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Описание фильма'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/prettyWoman.jpg',
                height: 250,
                alignment: Alignment.topLeft,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Красотка',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  Text('9 июля 1990',
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
