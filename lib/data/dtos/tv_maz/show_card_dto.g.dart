// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowCardDTO _$ShowCardDTOFromJson(Map<String, dynamic> json) => ShowCardDTO(
      score: (json['score'] as num?)?.toDouble(),
      show: json['show'] == null
          ? null
          : ShowCardDataDTO.fromJson(json['show'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowCardDTOToJson(ShowCardDTO instance) =>
    <String, dynamic>{
      'score': instance.score,
      'show': instance.show,
    };
