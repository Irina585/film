import 'package:film/data/dtos/tv_maz/show_card_data_image_dto.dart';
import 'package:film/data/dtos/tv_maz/show_card_data_rating_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_card_data_dto.g.dart';

@JsonSerializable()
class ShowCardDataDTO {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'image')
  final ShowCardDataImageDTO? picture;
  @JsonKey(ignore: true)
  final ShowCardDataRatingDTO? voteAverage;
  @JsonKey(name: 'premiered')
  final String releaseDate;
  @JsonKey(name: 'summary')
  final String description;
  @JsonKey(name: 'language')
  final String language;

  ShowCardDataDTO({
    required this.id,
    this.title = '',
    this.voteAverage,
    this.releaseDate = '',
    this.description = '',
    this.language = '',
    this.picture,
  });

  factory ShowCardDataDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataDTOFromJson(json);
}

/*
@JsonSerializable()
class ShowCardDataDTO {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'image')
  final ShowCardDataImageDTO picture;
  @JsonKey(name: 'rating')
  final ShowCardDataRatingDTO voteAverage;
  @JsonKey(name: 'premiered')
  final String releaseDate;
  @JsonKey(name: 'summary')
  final String description;
  @JsonKey(name: 'language')
  final String language;

  ShowCardDataDTO({
    required this.id,
    this.title = '',
    required this.picture,
    required this.voteAverage,
    this.releaseDate = '',
    this.description = '',
    this.language = '',
  });

 */
