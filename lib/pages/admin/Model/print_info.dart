import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'print_info.g.dart';

@JsonSerializable()
class PrintInfo extends FireStoreObject {
  @JsonKey()
  final String printAlias;
  @JsonKey()
  final String printEmail;
  @JsonKey()
  final double perPrice;
  @JsonKey()
  final String address;
  @JsonKey()
  final String storeName;
  @JsonKey()
  final double locX;
  @JsonKey()
  final double locY;

  PrintInfo({
    required this.printAlias,
    required this.printEmail,
    required this.perPrice,
    required this.address,
    required this.storeName,
    required this.locX,
    required this.locY,
  });

  factory PrintInfo.fromJson(Map<String, dynamic> json) =>
      _$PrintInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PrintInfoToJson(this);
}
