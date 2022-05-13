import 'package:film/components/const.dart';
import 'package:film/components/delayed_action.dart';
import 'package:film/components/general_classes.dart';
import 'package:film/components/strings.dart';
import 'package:film/data/dtos/tv_maz/show_card_dto.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/domain/models/home_model.dart';
import 'package:film/presentation/bloc/detail/bloc/detail_bloc.dart';
import 'package:film/presentation/bloc/detail/bloc/detail_state.dart';
import 'package:film/presentation/bloc/home/bloc/home_bloc.dart';
import 'package:film/presentation/bloc/home/bloc/home_event.dart';
import 'package:film/presentation/bloc/home/bloc/home_state.dart';
import 'package:film/presentation/bloc/home/widgets/film_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// реализация списка фильмов с помощью ListView.Builder

class FilmList extends StatefulWidget {
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  const FilmList({Key? key}) : super(key: key);

  static List<FilmCardModel> films = <FilmCardModel>[
    FilmCardModel(
        id: 0,
        title: 'Красотка',
        voteAverage: 8.0,
        picture: Strings.prettyWomanLink,
        releaseDate: '9 июля 1990',
        language: Language.english.toPrettyString(),
        description: Strings.prettyWomanDescription,
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 1,
        title: 'Гарфилд',
        voteAverage: 6.8,
        picture: Strings.garfildLink,
        releaseDate: '18 ноября 2004',
        description: Strings.garfildDescription,
        language: Language.english.toPrettyString(),
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 2,
        title: 'Один дома',
        voteAverage: 8.3,
        picture: Strings.homeAloneLink,
        releaseDate: '17 октября 1990',
        description: Strings.homeAloneDescription,
        language: Language.english.toPrettyString(),
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 3,
        title: 'Не смотри наверх',
        voteAverage: 7.5,
        picture: Strings.dontLookUpLink,
        releaseDate: '8 сентября 2021',
        description: Strings.dontLookUpDescription,
        language: Language.english.toPrettyString(),
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 4,
        title: 'Форест Гамп',
        voteAverage: 8.9,
        picture: Strings.forrestLink,
        releaseDate: '18 января 1994',
        description: Strings.forrestDescription,
        language: Language.english.toPrettyString(),
        icon: Icon(Icons.favorite)),
    FilmCardModel(
        id: 5,
        title: 'Холоп',
        voteAverage: 6.8,
        picture: Strings.holopLink,
        releaseDate: '25 сентября 2019',
        description: Strings.holopDescription,
        language: Language.russian.toPrettyString(),
        icon: Icon(Icons.favorite))
  ];

  @override
  State<FilmList> createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  /// Контроллер для работы с полем поиска
  final TextEditingController textController = TextEditingController();

  /// Наши данные по фильмам для отображения
  Future<HomeModel?>? dataLoadingState;

  /// Загрузим наши фильмы сразу при запуске
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        key: FilmList.globalKey,
        children: [
          const SizedBox(height: 10),
          // Поле поиска
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: TextField(
              controller: textController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: FilmLocal.search,
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
          BlocListener<DetailBloc, DetailState>(
            listener: (context, state) {
              if (state is StateFilmDetailTilePage) {
                Navigator.of(context).pushNamed('/filmDetailTilePage');
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (oldState, newState) =>
                    oldState.data != newState.data,
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
                                            return FilmTile(
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

  Future refresh() async {
    final url = Uri.parse('https://api.tvmaze.com/search/shows');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ShowCardDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Не удалось загрузить фильмы');
    }
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
