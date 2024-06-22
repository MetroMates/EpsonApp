import 'package:epson_app/pages/user/Controller/user_map_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class NaverMapView extends StatefulWidget {
  const NaverMapView({super.key});

  @override
  State<NaverMapView> createState() => _NaverMapViewState();
}

class _NaverMapViewState extends State<NaverMapView> {
  @override
  Widget build(BuildContext context) {
    final UserMapViewModel userMapViewModel = Get.find<UserMapViewModel>();

    // 최초에 setCenter() 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userMapViewModel.setCenter();
    });

    return Scaffold(
      body: Obx(() {
        if (userMapViewModel.initialCenter.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return NaverMap(
          forceGesture: true,
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
              target: userMapViewModel.initialCenter.value!,
              zoom: 14.2,
            ),
            activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
            locationButtonEnable: true,
          ),
          onMapReady: (controller) {
            userMapViewModel.setController(controller: controller);
          },
        );
      }),
    );
  }
}
