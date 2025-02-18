// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HarryPotterCharactersModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HarryPotterCharactersModel _$HarryPotterCharactersModelFromJson(
        Map<String, dynamic> json) =>
    HarryPotterCharactersModel(
      fullName: json['fullName'] as String,
      nickname: json['nickname'] as String,
      interpretedBy: json['interpretedBy'] as String,
      image: json['image'] as String,
      birthdate: json['birthdate'] as String,
    );

Map<String, dynamic> _$HarryPotterCharactersModelToJson(
        HarryPotterCharactersModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'nickname': instance.nickname,
      'interpretedBy': instance.interpretedBy,
      'image': instance.image,
      'birthdate': instance.birthdate,
    };
