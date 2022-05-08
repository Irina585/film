import 'package:flutter/material.dart';

// модель карточки фильма

class FilmCardModel {
  const FilmCardModel({
    required this.id,
    this.title = '',
    this.picture = '',
    this.voteAverage = 0,
    this.releaseDate = '',
    this.description = '',
    this.language = '',
    this.icon = const Icon(Icons.favorite),
  });

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;
  final Icon icon;
}
