// преобразование данных из DTO в модель
import 'package:film/data/dtos/tv_maz/show_card_dto.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:flutter/material.dart';

extension ShowCardFromDTOtoDomain on ShowCardDTO {
  get icon => const Icon(Icons.favorite);

  FilmCardModel toDomain() {
    return FilmCardModel(
      id: show?.id ?? 0,
      title: show?.title ?? '',
      picture: show?.picture?.original ?? '',
      //voteAverage: show?.voteAverage?.average ?? 0,
      releaseDate: show?.releaseDate ?? '',
      description: show?.description ?? '',
      language: show?.language ?? '',
      icon: icon,
    );
  }
}
