abstract class Film {
  const Film(this.id, this.title, this.picture, this.voteAverage,
      this.releaseDate, this.description, this.language);
  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;
}

class Comedy extends Film with FilmLanguageConverter {
  const Comedy(
      {required int id,
      required String title,
      required String picture,
      required double voteAverage,
      required String releaseDate,
      required String description,
      required String language})
      : super(id, title, picture, voteAverage, releaseDate, description,
            language);
}

enum Language { russian, english, unknown }

// конвертация языка из строки в enum Language
mixin FilmLanguageConverter {
  Language getFilmLanguage(String language) {
    switch (language) {
      case 'Английский':
        return Language.english;
      case 'Русский':
        return Language.russian;
      default:
        return Language.unknown;
    }
  }
}

// расширение enum Language, возвращающее строку с названием языка
extension FilmLanguageExtension on Language {
  String toPrettyString() {
    switch (this) {
      case Language.english:
        return 'Английский';
      case Language.russian:
        return 'Русский';
      case Language.unknown:
        return 'Не известный фильм';
    }
  }
}
