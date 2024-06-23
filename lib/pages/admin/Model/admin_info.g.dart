// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminInfo _$AdminInfoFromJson(Map<String, dynamic> json) => AdminInfo(
      clientID: json['clientID'] as String,
      clientSecretID: json['clientSecretID'] as String,
      hostName: json['hostName'] as String,
    );

Map<String, dynamic> _$AdminInfoToJson(AdminInfo instance) => <String, dynamic>{
      'clientID': instance.clientID,
      'clientSecretID': instance.clientSecretID,
      'hostName': instance.hostName,
    };
