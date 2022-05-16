import 'package:film/domain/models/home_model.dart';
import 'package:film/presentation/home/bloc/home_bloc.dart';
import 'package:film/presentation/home/bloc/home_event.dart';
import 'package:film/presentation/home/bloc/home_state.dart';
import 'package:film/presentation/home/widgets/film_card.dart';
import 'package:film/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:film/presentation/navigation/bloc/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'film_list.dart';

class FilmGrid extends StatefulWidget {
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  const FilmGrid({Key? key}) : super(key: key);

  @override
  State<FilmGrid> createState() => _FilmGridState();
}

class _FilmGridState extends State<FilmGrid> {
  // Загрузим наши фильмы сразу при запуске
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is StateFilmDetailTilePage) {
          Navigator.of(context).pushNamed('/filmDetailTilePage');
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (oldState, newState) => oldState.data != newState.data,
        builder: (context, state) {
          return FutureBuilder<HomeModel?>(
              key: FilmGrid.globalKey,
              future: state.data,
              builder: (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                return data.connectionState != ConnectionState.done
                    ? const Center(child: CircularProgressIndicator())
                    : data.hasData
                        ? data.data?.results?.isNotEmpty == true
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2 / 3),
                                // чтобы исчезала клавиатура при прокрутке экрана
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FilmCard(
                                        filmCardModel:
                                            data.data?.results?[index],
                                        key: ValueKey<int>(
                                            data.data?.results?[index].id ??
                                                -1),
                                      ));
                                },
                                itemCount: data.data?.results?.length ?? 0,
                              )
                            : const Empty()
                        : const Error();
              });
        },
      ),
    );
  }
}
