import 'package:json_annotation/json_annotation.dart';
part 'Book.g.dart';

@JsonSerializable()
class BookModel {
  final int number, pages, index;
  final String title, originalTitle, releaseDate, description, cover;

  BookModel(
      {required this.number,
      required this.pages,
      required this.index,
      required this.title,
      required this.originalTitle,
      required this.releaseDate,
      required this.description,
      required this.cover});

  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);
  Map<String,dynamic> toJson ()=> _$BookModelToJson(this);
}
