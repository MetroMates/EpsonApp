import 'dart:math';

import 'package:epson_app/services/epson/epson_service.dart';
import 'package:epson_app/services/location_service.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class UserMapViewModel extends GetxController {
  var locationPermissions = LocationPermissions.denied.obs;
  final LocationService _locationService = LocationService();
  NaverMapController? mapController;
  var initialCenter = Rx<NLatLng?>(null);
  var isMarkerClicked = false.obs;

  void setController({required NaverMapController controller}) {
    mapController = controller;
    print('mapController init');
    setMarkers();
  }

  void setCenter() async {
    locationPermissions.value = await _locationService.locationPermission();
    if (locationPermissions.value == LocationPermissions.deniedForever) return;
    final position = await _locationService.getMyPosition();
    initialCenter.value = NLatLng(position.latitude, position.longitude);
    print('setCenter');
  }

  // 네이버맵 마커 표시
  void setMarkers() {
    // 마커 생성 및 추가
    final marker = NMarker(
      // 말풍선에 역이름,라인 표시하기위해
      id: '1',
      position: initialCenter.value ?? const NLatLng(37.26939, 127.0193),
    );
    marker.setOnTapListener((NMarker marker) {
      getShop();
    });
    mapController?.addOverlay(marker);
  }

  void toggleMarker() {
    isMarkerClicked.value = false;
  }

  void getShop() async {
    final epson = EpsonService(printNm: DeviceName.one);
    await epson.createAuth();
    final response = await epson.getDeviceInfo();
    isMarkerClicked.value = true;
    // log(response?.data['printer_name'] ?? '');
  }
}
