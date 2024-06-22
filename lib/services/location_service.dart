import 'package:geolocator/geolocator.dart';

enum LocationPermissions {
  allow,
  serviceEnabled,
  denied,
  deniedForever;

  String get message {
    switch (this) {
      case LocationPermissions.allow:
        return '';
      case LocationPermissions.serviceEnabled:
        return '핸드폰 위치 서비스를 켜주세요.';
      case LocationPermissions.denied:
        return '위치 권한 설정을 허용해주세요.';
      case LocationPermissions.deniedForever:
        return '위치 권한 설정을 허용해주세요.';
    }
  }
}

final class LocationService {
  static final LocationService _instance = LocationService._();
  LocationService._();
  factory LocationService() => _instance;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  // 위치 권한 메서드
  Future<LocationPermissions> locationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. 위치 서비스 확인
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationPermissions.serviceEnabled;
    }
    // 2. 위치 권한 확인
    permission = await _geolocatorPlatform.checkPermission();

    // 2-1. 권한 거부된 경우
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationPermissions.denied;
      }
    }

    // 2-2. 영구적으로 거부된 경우
    if (permission == LocationPermission.deniedForever) {
      return LocationPermissions.deniedForever;
    }

    // 2-3. 권한 허용된 경우
    return LocationPermissions.allow;
  }

  Future<Position> getMyPosition() async {
    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }
}
