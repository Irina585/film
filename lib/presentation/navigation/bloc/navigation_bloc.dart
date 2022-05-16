import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(StateMainPage()) {
    on<PressedOnMainPage>((event, emit) => emit(StateMainPage()));
    on<PressedOnFilmDetailTilePage>(
        (event, emit) => emit(StateFilmDetailTilePage()));
  }
}
