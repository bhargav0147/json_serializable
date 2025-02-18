// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      number: (json['number'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      title: json['title'] as String,
      originalTitle: json['originalTitle'] as String,
      releaseDate: json['releaseDate'] as String,
      description: json['description'] as String,
      cover: json['cover'] as String,
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'number': instance.number,
      'pages': instance.pages,
      'index': instance.index,
      'title': instance.title,
      'originalTitle': instance.originalTitle,
      'releaseDate': instance.releaseDate,
      'description': instance.description,
      'cover': instance.cover,
    };
