import 'dart:math';

import 'package:epson_app/services/location_service.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class UserMapViewModel extends GetxController {
  var locationPermissions = LocationPermissions.denied.obs;
  final LocationService _locationService = LocationService();
  NaverMapController? mapController;
  var initialCenter = Rx<NLatLng?>(null);

  void setController({required NaverMapController controller}) {
    mapController = controller;
  }

  void setCenter() async {
    locationPermissions.value = await _locationService.locationPermission();
    if (locationPermissions.value == LocationPermissions.deniedForever) return;
    final position = await _locationService.getMyPosition();
    initialCenter.value = NLatLng(position.latitude, position.longitude);
  }

  // 네이버맵 마커 표시
  // void setMarkers(NaverMapController controller) {
  //   // 마커 생성 및 추가
  //   final markers =
  //       nearStations.map((station) => _createMarker(station)).toSet();
  //   controller.addOverlayAll(markers);

  // }

  // NMarker _createMarker() {
  //   return NMarker(
  //     // 말풍선에 역이름,라인 표시하기위해
  //     id: '${station.statnId}/${station.statnNm}/${station.route}',
  //     position: NLatLng(station.crdntY, station.crdntX),
  //   );
  // }
}
