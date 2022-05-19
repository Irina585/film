import 'package:equatable/equatable.dart';
import 'package:film/domain/models/film_card_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SearchChangedEvent extends HomeEvent {
  final String search;
  const SearchChangedEvent({required this.search});
  @override
  List<Object> get props => [search];
}

class LoadDataEvent extends HomeEvent {}

class LoadRefreshEvent extends HomeEvent {}

// Добавление / удаление избарнного по клику на кнопку
class ChangedFavorites extends HomeEvent {
  final FilmCardModel? model;

  const ChangedFavorites({required this.model});
}

// Событие об изменении данных в БД
class ChangedFilmsDB extends HomeEvent {
  final List<FilmCardModel> models;
  const ChangedFilmsDB({required this.models});
}
