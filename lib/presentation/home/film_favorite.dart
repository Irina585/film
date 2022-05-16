import 'package:film/app/components/const.dart';
import 'package:film/domain/models/home_model.dart';
import 'package:film/presentation/home/bloc/home_bloc.dart';
import 'package:film/presentation/home/bloc/home_event.dart';
import 'package:film/presentation/home/bloc/home_state.dart';
import 'package:film/presentation/home/film_list.dart';
import 'package:film/presentation/home/widgets/film_tile.dart';
import 'package:film/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:film/presentation/navigation/bloc/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class FilmFavorite extends StatefulWidget {
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  const FilmFavorite({Key? key}) : super(key: key);

  @override
  State<FilmFavorite> createState() => _FilmFavoriteState();
}

class _FilmFavoriteState extends State<FilmFavorite> {
  /// Загрузим наши фильмы сразу при запуске
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: FilmList.globalKey,
        children: [
          const SizedBox(height: 10),
          // список фильмов
          BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              if (state is StateFilmDetailTilePage) {
                Navigator.of(context).pushNamed('/filmDetailTilePage');
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (oldState, newState) =>
                    oldState.data != newState.data ||
                    // добавим, что именно список будет перерисовывать при изменении
                    // списка избранных
                    oldState.favoritesFilms != newState.favoritesFilms,
                builder: (context, state) {
                  return FutureBuilder<HomeModel?>(
                    future: state.data,
                    builder:
                        (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                      return data.connectionState != ConnectionState.done
                          ? const Center(child: CircularProgressIndicator())
                          : data.hasData
                              ? data.data?.results?.isNotEmpty == true
                                  ? Expanded(
                                      child: ListView.builder(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // проверяем есть ли элемент в избранном
                                          bool isFavorite = false;
                                          if (state
                                                  .favoritesFilms?.isNotEmpty ==
                                              true) {
                                            var filmsFavorite = state
                                                .favoritesFilms
                                                ?.firstWhereOrNull((element) =>
                                                    element.id ==
                                                    state.favoritesFilms?[index]
                                                        .id);
                                            if (filmsFavorite != null) {
                                              isFavorite = true;
                                            }
                                          }
                                          return FilmTile(
                                            // в зависимости от состояния меняем текст
                                            textButton: isFavorite
                                                ? FilmLocal.deleteFavorites
                                                : FilmLocal.addFavorites,
                                            // CallBack по клику на кнопку
                                            onClickFavoriteButton: () {
                                              //отправляем событие в блок
                                              context.read<HomeBloc>().add(
                                                    //сообщаем в Bloc, что нужно изменить избранное
                                                    ChangedFavorites(
                                                        model: state
                                                                .favoritesFilms?[
                                                            index]),
                                                  );
                                            },
                                            filmCardModel:
                                                state.favoritesFilms?[index],
                                            key: ValueKey<int>(state
                                                    .favoritesFilms?[index]
                                                    .id ??
                                                -1),
                                          );
                                        },
                                        itemCount:
                                            //data.data?.results?.length ?? 0,
                                            state.favoritesFilms?.length ?? 0,
                                      ),
                                    )
                                  : const Empty()
                              : const Error();
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
