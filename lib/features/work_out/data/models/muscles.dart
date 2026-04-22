import 'package:json_annotation/json_annotation.dart';

part 'muscles.g.dart';

@JsonSerializable()
class Muscles {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  Muscles({this.Id, this.name, this.image});

  factory Muscles.fromJson(Map<String, dynamic> json) {
    return _$MusclesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesToJson(this);
  }
}
