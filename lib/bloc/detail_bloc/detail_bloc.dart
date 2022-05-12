import 'package:film/bloc/detail_bloc/detail_event.dart';
import 'package:film/bloc/detail_bloc/detail_state.dart';
import 'package:film/presentation/pages/film_detail_tile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(StateMainPage()) {
    on<PressedOnMainPage>((event, emit) => emit(StateMainPage()));
    on<PressedOnFilmDetailTilePage>(
        (event, emit) => emit(StateFilmDetailTilePage()));
  }
}
