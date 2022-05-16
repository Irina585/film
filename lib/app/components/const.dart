import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Константы для запросов
class FilmQuery {
  static const String baseUrl = 'https://api.tvmaze.com/search/shows';
  static const String pisecImageUrl = 'https://a.d-cd.net/KiAAAgCig-A-960.jpg';
  static const String nothingImageUrl =
      'https://images.pexels.com/photos/994605/pexels-photo-994605.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';
  static const String initialQ = 'world';
}

/// Константы локализации
class FilmLocal {
  static const String error = 'Ошибка';
  static const String unknown = 'Неизвестно';
  static const String ratingPrefix = 'Оценка: ';
  static const String ratingSuffix = '/ 10';
  static const String search = 'Поиск';
  static const String addFavorites = 'Добавить в избранное';
  static const String deleteFavorites = 'Удалить из избранного';

  static const titleApp = 'Фильмы';
  static const titleAppFilter = 'Фильтр фильмов';
  static const favorite = 'Избранное';
  static const searchFilm = 'Поиск';
}

/// Константы изображений
class FilmPictures {
  static CacheManager pictureCache =
      CacheManager(Config('movieImg', stalePeriod: const Duration(days: 7)));
}
