import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends FireStoreObject {
  @JsonKey()
  final String email;
  @JsonKey()
  final String nickName;

  User({
    required this.email,
    required this.nickName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
