// ignore: file_names
import 'package:json_annotation/json_annotation.dart';
part 'HarryPotterBookModel.g.dart';

@JsonSerializable()
class HarryPotterBookModel {
  final int number, pages, index;
  final String title, originalTitle, releaseDate, description, cover;

  HarryPotterBookModel(
      {required this.number,
      required this.pages,
      required this.index,
      required this.title,
      required this.originalTitle,
      required this.releaseDate,
      required this.description,
      required this.cover});

  factory HarryPotterBookModel.fromJson(Map<String, dynamic> json) => _$HarryPotterBookModelFromJson(json);
  Map<String,dynamic> toJson ()=> _$HarryPotterBookModelToJson(this);
}
