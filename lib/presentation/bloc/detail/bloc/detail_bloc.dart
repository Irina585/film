import 'package:film/presentation/bloc/detail/bloc/detail_event.dart';
import 'package:film/presentation/bloc/detail/bloc/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(StateMainPage()) {
    on<PressedOnMainPage>((event, emit) => emit(StateMainPage()));
    on<PressedOnFilmDetailTilePage>(
        (event, emit) => emit(StateFilmDetailTilePage()));
  }
}
