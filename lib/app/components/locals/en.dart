import 'locale_base.dart';

class LocaleEn implements LocaleBase {
  @override
  String get error => 'Error';
  @override
  String get unknown => 'Unknown';
  @override
  String get ratingPrefix => 'Rating: ';
  @override
  String get ratingSuffix => '/ 10';

  @override
  String get search => 'Search';
  @override
  String get switchLanguage => 'Switch language';
  @override
  String get addFavorites => 'Add to favorites';
  @override
  String get deleteFavorites => 'Remove from favorites';
  @override
  String get titleApp => 'Movies';
  @override
  String get titleAppFilter => 'Movie filter';
  @override
  String get favorite => 'Favorites';
  @override
  String get searchFilm => 'Search';
  @override
  String get releaseDate => 'Release date:';
  @override
  String get language => 'Language:';

  @override
  String get getName => 'Get a name';
  @override
  String get saveName => 'Save name';
  @override
  String get clearName => 'Clear name';
  @override
  String get settings => 'Settings';
}
