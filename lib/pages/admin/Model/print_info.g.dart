// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrintInfo _$PrintInfoFromJson(Map<String, dynamic> json) => PrintInfo(
      printAlias: json['printAlias'] as String,
      printEmail: json['printEmail'] as String,
      perPrice: (json['perPrice'] as num).toDouble(),
      address: json['address'] as String,
      storeName: json['storeName'] as String,
      locX: (json['locX'] as num).toDouble(),
      locY: (json['locY'] as num).toDouble(),
    );

Map<String, dynamic> _$PrintInfoToJson(PrintInfo instance) => <String, dynamic>{
      'printAlias': instance.printAlias,
      'printEmail': instance.printEmail,
      'perPrice': instance.perPrice,
      'address': instance.address,
      'storeName': instance.storeName,
      'locX': instance.locX,
      'locY': instance.locY,
    };
