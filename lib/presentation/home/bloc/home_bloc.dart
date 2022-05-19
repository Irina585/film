import 'package:film/app/components/const.dart';
import 'package:film/data/repositories/films_repositories.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/presentation/home/bloc/home_event.dart';
import 'package:film/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FilmsRepository repository;
  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangedEvent>(_onSearchChanged);
    on<ChangedFavorites>(_onClickFavorites);
    on<ChangedFilmsDB>(_onChangedDB);
    on<LoadRefreshEvent>(_onLoadRefresh);

    // Подписываемя на Stream об изменении данных в БД
    repository.onChangedFilmsDB().listen((
      List<FilmCardModel> changedFilmDB,
    ) {
      add(ChangedFilmsDB(models: changedFilmDB));
    });
  }

  String get search {
    final stateSearch = state.search;
    return (stateSearch != null && stateSearch.isNotEmpty)
        ? stateSearch
        : FilmQuery.initialQ;
  }

  void _onSearchChanged(SearchChangedEvent event, Emitter<HomeState> emit) {
    // изменение поля поиска
    emit(state.copyWith(search: event.search));
    // загрузка новых данных
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onLoadRefresh(LoadRefreshEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onClickFavorites(
      ChangedFavorites event, Emitter<HomeState> emit) async {
    final FilmCardModel? targetFilm = event.model;

    FilmCardModel? movie;
    // Проверяем что список избранных не пуст
    if (state.favoritesFilms?.isNotEmpty == true) {
      // проверяем есть ли в избранном фильм
      movie = state.favoritesFilms
          ?.firstWhereOrNull((element) => element.id == targetFilm?.id);
    }

    // если есть -  удаляем из базы, если нет то добавляем в базу
    if (movie != null) {
      await repository.deleteFilmDB(movie.id);
    } else if (targetFilm != null) {
      await repository.insertFilmDB(targetFilm);
    }
  }

  void _onChangedDB(ChangedFilmsDB event, Emitter<HomeState> emit) {
    emit(state.copyWith(favoritesFilms: event.models));
  }
}
