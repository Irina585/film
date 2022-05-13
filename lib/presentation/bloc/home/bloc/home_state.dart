import 'package:equatable/equatable.dart';
import 'package:film/domain/models/home_model.dart';

class HomeState extends Equatable {
  //данные, вводимые в строку поиска фильмов
  final String? search;
  // данные списка фильмов
  final Future<HomeModel?>? data;

  const HomeState({this.search, this.data});

  // метод copyWith принимает новые значения для наших полей
  HomeState copyWith({String? search, Future<HomeModel?>? data}) => HomeState(
        search: search ?? this.search,
        data: data ?? this.data,
      );
  @override
  // сравнение запроса в поле поиска и данных в списке фильмов
  List<Object> get props => [search ?? 0, data ?? 0];
}
