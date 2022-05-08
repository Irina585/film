import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';

const mainTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    overflow: TextOverflow.ellipsis);
const subTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontWeight: FontWeight.normal,
    overflow: TextOverflow.ellipsis);
const boldTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis);

/// Константы для запросов
class FilmQuery {
  static const String baseUrl = 'https://api.tvmaze.com/search/shows';
  static const String pisecImageUrl = 'https://a.d-cd.net/KiAAAgCig-A-960.jpg';
  static const String nothingImageUrl =
      'https://images.pexels.com/photos/994605/pexels-photo-994605.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';
  static const String initialQ = 'bad';
}

/// Константы локализации
class FilmLocal {
  static const String error = 'Ошибка';
  static const String unknown = 'Неизвестно';
  static const String ratingPrefix = 'Оценка: ';
  static const String ratingSuffix = '/ 10';
  static const String search = 'Поиск';
}

/// Константы изображений
class FilmPictures {
  static CacheManager pictureCache =
      CacheManager(Config('movieImg', stalePeriod: const Duration(days: 7)));
}

/*
  static const String baseUrl = 'https://api.themoviedb.org/3/movie/';
  static const String imageUrl = 'https://image.tmdb.org/t/p/w300';
  static const String queryPopular = 'popular';
  static const String apiKey = '6a56f395a2c6c28a391ee4134553cc5f';
  static Map<String, dynamic> queryParametersBase = <String, dynamic>{
    'api_key': FilmQuery.apiKey
 */
