import 'package:json_annotation/json_annotation.dart';
// Json 직렬화를 위해  JsonSerializable 어노테이션 추가 후 post.g.dart 추가
part 'post.g.dart';
@JsonSerializable()
class PostModel {
  const PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });
  final int userId;
  final int id;
  final String title;
  final String body;

  // fromJson / toJson 자동생성 객체. build_runner로 실행 시 생성됨
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() =>  _$PostModelToJson(this);
}