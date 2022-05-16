import 'locale_base.dart';

class LocaleRu implements LocaleBase {
  @override
  String get error => 'Ошибка';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get ratingPrefix => 'Оценка: ';

  @override
  String get ratingSuffix => '/ 10';

  @override
  String get search => 'Поиск';

  @override
  String get switchLanguage => 'Сменить язык';

  @override
  String get addFavorites => 'Добавить в избранное';

  @override
  String get deleteFavorites => 'Удалить из избранного';

  @override
  String get titleApp => 'Фильмы';

  @override
  String get titleAppFilter => 'Фильтр фильмов';

  @override
  String get favorite => 'Избранное';

  @override
  String get searchFilm => 'Поиск';
}
