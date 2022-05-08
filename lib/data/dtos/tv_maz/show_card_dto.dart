import 'package:film/data/dtos/tv_maz/show_card_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_card_dto.g.dart';

// конвертация данных объекта из формата Json
@JsonSerializable()
class ShowCardDTO {
  @JsonKey(name: 'score')
  final double? score;

  @JsonKey(name: 'show')
  final ShowCardDataDTO? show;

  ShowCardDTO({this.score, this.show});

  factory ShowCardDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDTOFromJson(json);
}
