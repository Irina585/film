import 'package:equatable/equatable.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/domain/models/home_model.dart';

class HomeState extends Equatable {
  //данные, вводимые в строку поиска фильмов
  final String? search;
  // данные списка фильмов
  final Future<HomeModel?>? data;
  final Future<HomeModel?>? refresh;
  // добавляем список избранных
  final List<FilmCardModel>? favoritesFilms;

  const HomeState({this.search, this.data, this.favoritesFilms, this.refresh});

  // метод copyWith принимает новые значения для наших полей
  HomeState copyWith({
    String? search,
    Future<HomeModel?>? data,
    List<FilmCardModel>? favoritesFilms,
    Future<HomeModel?>? refresh,
  }) =>
      HomeState(
          search: search ?? this.search,
          data: data ?? this.data,
          favoritesFilms: favoritesFilms ?? this.favoritesFilms,
          refresh: refresh ?? this.refresh);
  @override
  // сравнение запроса в поле поиска и данных в списке фильмов
  List<Object> get props => [
        search ?? 0,
        data ?? 0,
        favoritesFilms ?? [],
        refresh ?? 0,
      ];
}
