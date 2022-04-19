// модель карточки фильма
import 'package:flutter/cupertino.dart';

class FilmCardModel {
  const FilmCardModel({
    required this.id,
    this.title = '',
    this.picture = '',
    this.voteAverage = 0,
    this.releaseDate = '',
    this.description = '',
    required this.icon,
  });

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final Icon icon;
}
