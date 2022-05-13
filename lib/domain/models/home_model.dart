import 'package:film/domain/models/film_card_model.dart';

// Чистая модель нашего главного окна

class HomeModel {
  final List<FilmCardModel>? results;
  HomeModel({this.results});
}
