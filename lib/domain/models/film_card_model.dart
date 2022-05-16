import 'package:film/data/db/database.dart';
import 'package:flutter/material.dart';

/// Чистая модель карточки с фильмом для отображения на UI

class FilmCardModel {
  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
  final String language;
  final Icon icon;

  const FilmCardModel({
    required this.id,
    required this.title,
    this.picture = '',
    this.voteAverage = 0,
    this.releaseDate = '',
    this.description = '',
    this.language = '',
    this.icon = const Icon(Icons.favorite),
  });
}

// Функция преобразования из [FilmCardModel] в [FilmTableData]
extension FilmCardModelToDatabase on FilmCardModel {
  FilmTableData toDatabase() {
    return FilmTableData(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
    );
  }
}

// Функция преобразования из [FilmTableData] в [FilmCardModel]
extension FilmTableDataToDomain on FilmTableData {
  FilmCardModel toDomain() {
    return FilmCardModel(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
    );
  }
}
