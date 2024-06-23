import 'package:json_annotation/json_annotation.dart';

part 'admin_info.g.dart';

/// 유저 회원정보
@JsonSerializable()
class AdminInfo {
  @JsonKey()
  final String clientID;
  @JsonKey()
  final String clientSecretID;
  @JsonKey()
  final String hostName;

  AdminInfo({
    required this.clientID,
    required this.clientSecretID,
    required this.hostName,
  });

  factory AdminInfo.fromJson(Map<String, dynamic> json) =>
      _$AdminInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInfoToJson(this);
}


// class AdminInfo {
//   final String belong;
//   final String clientID;
//   final String clientSecretID;
//   final String hostName;
//   final List<User> users;

//   AdminInfo(
//       {required this.belong,
//       required this.clientID,
//       required this.clientSecretID,
//       required this.hostName,
//       required this.users});

//   factory AdminInfo.fromJson(Map<String, dynamic> json) {
//     return AdminInfo(
//       belong: json['belong'] as String,
//       clientID: json['clientID'] as String,
//       clientSecretID: json['clientSecretID'] as String,
//       hostName: json['hostName'] as String,
//       users: (json['comment'] as List<dynamic>?)
//               ?.map((users) => User.fromJson(users))
//               .toList() ??
//           [],
//     );
//   }
// }

// class User {
//   final String email;
//   final String name;

//   User({
//     required this.email,
//     required this.name,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       email: json['email'] as String,
//       name: json['name'] as String,
//     );
//   }
// }
