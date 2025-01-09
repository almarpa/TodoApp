import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat_entity.g.dart';

@JsonSerializable()
class CatEntity extends Equatable {
  final String fact;
  final int length;

  const CatEntity({required this.fact, required this.length});

  static CatEntity fromJson(Map<String, dynamic> json) =>
      _$CatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CatEntityToJson(this);

  @override
  List<Object?> get props => [fact, length];
}
