import 'package:json_annotation/json_annotation.dart';

part 'show_card_data_rating_dto.g.dart';

@JsonSerializable()
class ShowCardDataRatingDTO {
  @JsonKey(name: 'average', defaultValue: 0)
  final double? average;

  ShowCardDataRatingDTO({
    this.average,
  });

  factory ShowCardDataRatingDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataRatingDTOFromJson(json);
}
