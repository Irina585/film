import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:film/app/components/const.dart';
import 'package:film/data/db/database.dart';
import 'package:film/data/dtos/tv_maz/show_card_dto.dart';
import 'package:film/data/mappers/show_card_from_dto_to_domain.dart';
import 'package:film/data/repositories/interceptors/dio_error_interceptor.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/domain/models/home_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Репозиторий для получения данных о фильмах
class FilmsRepository {
  /// Метод обработчик наших ошибок
  final Function(String, String) onErrorHandler;

  /// Наш основной объект для выполнения запросов
  late final Dio _dio;

  /// Объект базы данных
  late final Database _db;

  FilmsRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);

    /// Инициализируем базу данных
    _db = Database();
  }

  /// Метод получения данных
  Future<HomeModel?> loadData({required String q}) async {
    // Выполняем запрос
    const String url = FilmQuery.baseUrl;
    final Response<dynamic> response = await _dio.get<List<dynamic>>(
      url,
      queryParameters: <String, dynamic>{'q': q},
    );

    // Парсим ДТО
    final dtos = <ShowCardDTO>[];
    final responseList = response.data as List<dynamic>;
    for (final data in responseList) {
      dtos.add(ShowCardDTO.fromJson(data as Map<String, dynamic>));
    }

    // Конвертируем ДТО в модели
    final filmModels = <FilmCardModel>[];

    for (final dto in dtos) {
      filmModels.add(dto.toDomain());
    }

    // Собираем модели карточек фильмов и возвращаем единую модель
    final HomeModel model = HomeModel(results: filmModels);
    return model;
  }

  /// Получаем весь список фильмов из базы
  Future<List<FilmCardModel>> getAllFilmsDB() async {
    // Получаем список объектов из базы в моделях БД
    List<FilmTableData> filmsDB = await _db.select(_db.filmTable).get();
    // Преобразуем модели БД в понятные модели для наших виджетов
    return filmsDB
        .map((FilmTableData filmTableData) => filmTableData.toDomain())
        .toList();
  }

  /// Добавляем элемент из базы по ID
  Future<void> insertFilmDB(FilmCardModel filmCardModel) async {
    // Передаем нашу модель и преобразуем её в модель для БД с помощью .toDatabase()
    await _db.into(_db.filmTable).insert(
          filmCardModel.toDatabase(),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Удаляем элемент из базы по ID
  Future<void> deleteFilmDB(int id) async {
    await (_db.delete(_db.filmTable)
          ..where((filmTable) => filmTable.id.equals(id)))
        .go();
  }

  /// Подписка на изменения в БД
  Stream<List<FilmCardModel>> onChangedFilmsDB() {
    return (_db.select(_db.filmTable))
        .map((FilmTableData filmTableData) => filmTableData.toDomain())
        .watch();
  }
}
