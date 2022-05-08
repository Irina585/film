import 'package:film/components/const.dart';
import 'package:film/components/delayed_action.dart';
import 'package:film/components/general_classes.dart';
import 'package:film/components/strings.dart';
import 'package:film/data/reppositories/films_repositories.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/domain/models/home_model.dart';
import 'package:film/presentation/widgets/film_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// реализация списка фильмов с помощью ListView.Builder

class FilmList extends StatefulWidget {
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
    dataLoadingState ??=
        FilmsRepository.loadData(context, q: FilmQuery.initialQ);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    FilmsRepository.loadData(context, q: FilmQuery.initialQ);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        // Cписок фильмов
        FutureBuilder<HomeModel?>(
          future: dataLoadingState,
          builder: (BuildContext context, AsyncSnapshot<HomeModel?> data) {
            return data.connectionState != ConnectionState.done
                ? const Center(child: CircularProgressIndicator())
                : data.hasData
                    ? data.data?.results?.isNotEmpty == true
                        ? Expanded(
                            child: ListView.builder(
                              // чтобы исчезала клавиатура при прокрутке экрана
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder: (BuildContext context, int index) {
                                return FilmTile(
                                  filmCardModel: data.data?.results?[index],
                                  key: ValueKey<int>(
                                      data.data?.results?[index].id ?? -1),
                                );
                              },
                              itemCount: data.data?.results?.length ?? 0,
                            ),
                          )
                        : const _Empty()
                    : const _Error();
          },
        ),
      ],
    );
  }

  /// Данный метод вызывается каждый раз при изменениях в поле поиска
  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      dataLoadingState = FilmsRepository.loadData(
        context,
        q: text.isNotEmpty ? text : FilmQuery.initialQ,
      );
      setState(() {});
    });
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      FilmQuery.pisecImageUrl,
      fit: BoxFit.cover,
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      FilmQuery.nothingImageUrl,
      fit: BoxFit.cover,
    );
  }
}
