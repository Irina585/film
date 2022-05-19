import 'package:film/app/components/const.dart';
import 'package:film/app/components/delayed_action.dart';
import 'package:film/app/components/locals/locals.dart';
import 'package:film/domain/models/home_model.dart';
import 'package:film/presentation/home/bloc/home_bloc.dart';
import 'package:film/presentation/home/bloc/home_event.dart';
import 'package:film/presentation/home/bloc/home_state.dart';
import 'package:film/presentation/home/widgets/film_tile.dart';
import 'package:film/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:film/presentation/navigation/bloc/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../settings/bloc/settings_bloc.dart';
import '../settings/bloc/settings_event.dart';
import '../settings/bloc/settings_state.dart';

// реализация списка фильмов с помощью ListView.Builder

class FilmList extends StatefulWidget {
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  const FilmList({
    Key? key,
  }) : super(key: key);

  @override
  State<FilmList> createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  /// Контроллер для работы с полем поиска
  final TextEditingController textController = TextEditingController();

  /// Загрузим наши фильмы сразу при запуске
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  Future refresh() async {
    context.read<HomeBloc>().add(LoadRefreshEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        key: FilmList.globalKey,
        children: [
          const SizedBox(height: 10),
          // Чекбокс для тестирования смены локализации
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                BlocBuilder<SettingBloc, SettingState>(
                  builder: (context, state) {
                    return Checkbox(
                      value: state.isEnLocale,
                      onChanged: (val) {
                        final isEnLocale = val ?? false;
                        context
                            .read<SettingBloc>()
                            .add(UpdateLocaleEvent(value: isEnLocale));
                      },
                    );
                  },
                ),
                Flexible(
                  child: Text(
                    context.locale.switchLanguage,
                  ),
                ),
              ],
            ),
          ),

          // Поле поиска
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: TextField(
              controller: textController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: context.locale.search,
                  filled: true,
                  border: const OutlineInputBorder(),
                  fillColor: Colors.white.withAlpha(230),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      textController.clear();
                    },
                  )),
              onChanged: _onSearchFieldTextChanged,
            ),
          ),
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
                                      child: RefreshIndicator(
                                        onRefresh: refresh,
                                        child: ListView.builder(
                                          // чтобы исчезала клавиатура при прокрутке экрана
                                          keyboardDismissBehavior:
                                              ScrollViewKeyboardDismissBehavior
                                                  .onDrag,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // проверяем есть ли элемент в избранном
                                            bool isFavorite = false;
                                            if (state.favoritesFilms
                                                    ?.isNotEmpty ==
                                                true) {
                                              var filmsFavorite = state
                                                  .favoritesFilms
                                                  ?.firstWhereOrNull(
                                                      (element) =>
                                                          element.id ==
                                                          data
                                                              .data
                                                              ?.results?[index]
                                                              .id);
                                              if (filmsFavorite != null) {
                                                isFavorite = true;
                                              }
                                            }
                                            return FilmTile(
                                              // в зависимости от состояния меняем текст
                                              iconButton: isFavorite
                                                  ? const Icon(Icons.favorite)
                                                  : const Icon(
                                                      Icons.favorite_border),
                                              // CallBack по клику на кнопку
                                              onClickFavoriteButton: () {
                                                //отправляем событие в блок
                                                context.read<HomeBloc>().add(
                                                      ChangedFavorites(
                                                          model: data.data
                                                                  ?.results?[
                                                              index]),
                                                    );
                                              },
                                              filmCardModel:
                                                  data.data?.results?[index],
                                              key: ValueKey<int>(data.data
                                                      ?.results?[index].id ??
                                                  -1),
                                            );
                                          },
                                          itemCount:
                                              data.data?.results?.length ?? 0,
                                        ),
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

  // Данный метод вызывается каждый раз при изменениях в поле поиска
  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      context.read<HomeBloc>().add(SearchChangedEvent(search: text));
    });
  }
}

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      FilmQuery.pisecImageUrl,
      fit: BoxFit.cover,
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      FilmQuery.nothingImageUrl,
      fit: BoxFit.cover,
    );
  }
}
