import 'package:dio/dio.dart';
import 'package:film/components/const.dart';
import 'package:film/data/dtos/tv_maz/show_card_dto.dart';
import 'package:film/data/mappers/show_card_from_dto_to_domain.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/domain/models/home_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Репозиторий для получения данных о фильме
class FilmsRepository {
  // метод обработчик ошибок
  final Function(String, String) onErrorHandler;

  // Основной объект для выполнения запросов
  late final Dio _dio;

  FilmsRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(requestHeader: true, requestBody: true),
        ErrorInterceptor(onErrorHandler),
      ]);
  }
// метод получения данных
  Future<HomeModel?> loadData({required String q}) async {
    // выполняем запрос
    const String url = FilmQuery.baseUrl;
    final Response<dynamic> response = await _dio
        .get<List<dynamic>>(url, queryParameters: <String, dynamic>{'q': q});

    // парсим DTO
    final dtos = <ShowCardDTO>[];
    final responseList = response.data as List<dynamic>;
    for (final data in responseList) {
      dtos.add(ShowCardDTO.fromJson(data as Map<String, dynamic>));
    }

    // конвертируем DTO в модели
    final filmModels = <FilmCardModel>[];
    for (final dto in dtos) {
      filmModels.add(dto.toDomain());
    }

    //собираем модели карточек фильмов и возвращаем единую модель
    final HomeModel model = HomeModel(results: filmModels);
    return model;
  }
}

//прерыватель ошибок
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this.onErrorHandler);
  final Function(String, String) onErrorHandler;
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    onErrorHandler(
      err.response?.statusCode?.toString() ?? FilmLocal.unknown,
      err.message,
    );
    handler.next(err);
  }
}
