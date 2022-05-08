import 'package:json_annotation/json_annotation.dart';

part 'show_card_data_image_dto.g.dart';

@JsonSerializable()
class ShowCardDataImageDTO {
  @JsonKey(name: 'original', defaultValue: '')
  final String? original;

  ShowCardDataImageDTO({
    this.original,
  });

  factory ShowCardDataImageDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataImageDTOFromJson(json);
}
