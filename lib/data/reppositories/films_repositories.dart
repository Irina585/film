import 'package:dio/dio.dart';
import 'package:film/components/const.dart';
import 'package:film/components/dialogs/error_dialog.dart';
import 'package:film/data/dtos/tv_maz/show_card_dto.dart';
import 'package:film/data/mappers/show_card_from_dto_to_domain.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/domain/models/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Репозиторий для получения данных о фильме
class FilmsRepository {
  // Основной объект для выполнения запросов
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  static Future<HomeModel?> loadData(BuildContext context,
      {required String q}) async {
    // выполняем запрос
    try {
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
    } on DioError catch (error) {
      //при ошибке покажем её в диалоге
      final statusCode = error.response?.statusCode;
      showErrorDialog(context, error: statusCode?.toString() ?? '');
      return null;
    }
  }
}
