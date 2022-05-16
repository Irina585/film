// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_card_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowCardDataDTO _$ShowCardDataDTOFromJson(Map<String, dynamic> json) =>
    ShowCardDataDTO(
      id: json['id'] as int? ?? 0,
      title: json['name'] as String? ?? '',
      releaseDate: json['premiered'] as String? ?? '',
      description: json['summary'] as String? ?? '',
      language: json['language'] as String? ?? '',
      picture: json['image'] == null
          ? null
          : ShowCardDataImageDTO.fromJson(
              json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowCardDataDTOToJson(ShowCardDataDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'image': instance.picture,
      'premiered': instance.releaseDate,
      'summary': instance.description,
      'language': instance.language,
    };
