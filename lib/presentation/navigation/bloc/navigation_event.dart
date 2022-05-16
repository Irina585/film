abstract class NavigationEvent {}

//сообщает NavigationBloc, что нажали на открытие экрана MainPage
class PressedOnMainPage extends NavigationEvent {}

//сообщает NavigationBloc, что нажали на открытие экрана FilmDetailTilePage
class PressedOnFilmDetailTilePage extends NavigationEvent {}
