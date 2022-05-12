
abstract class DetailEvent {}

//сообщает NavigationBloc, что нажали на открытие экрана MainPage
class PressedOnMainPage extends DetailEvent {}

//сообщает NavigationBloc, что нажали на открытие экрана FilmDetailTilePage
class PressedOnFilmDetailTilePage extends DetailEvent {}
