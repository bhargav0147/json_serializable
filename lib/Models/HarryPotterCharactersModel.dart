
import 'package:json_annotation/json_annotation.dart';
part 'HarryPotterCharactersModel.g.dart';

@JsonSerializable()
class HarryPotterCharactersModel {
  final String fullName, nickname, interpretedBy, image, birthdate;

  HarryPotterCharactersModel(
      {required this.fullName,
      required this.nickname,
      required this.interpretedBy,
      required this.image,
      required this.birthdate});

  factory HarryPotterCharactersModel.fromJson(Map<String,dynamic> json) => _$HarryPotterCharactersModelFromJson(json);
  Map<String,dynamic> toJson ()=> _$HarryPotterCharactersModelToJson(this);
}
