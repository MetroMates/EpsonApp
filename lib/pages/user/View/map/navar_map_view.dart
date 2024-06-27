import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/print_regist/print_regist_page.dart';
import 'package:epson_app/pages/user/Controller/user_map_viewmodel.dart';
import 'package:epson_app/pages/user/View/map/user_shop_card_view.dart';
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
    final UserMapViewModel userMapViewModel =
        GetxManager.instance<UserMapViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userMapViewModel.setCenter();
      userMapViewModel.isMarkerClicked.value = false;
    });

    return Scaffold(
      body: Obx(
        () {
          if (userMapViewModel.initialCenter.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              NaverMap(
                forceGesture: true,
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: userMapViewModel.initialCenter.value!,
                    zoom: 14.2,
                  ),
                  activeLayerGroups: [
                    NLayerGroup.building,
                    NLayerGroup.transit
                  ],
                  locationButtonEnable: true,
                ),
                onMapReady: (controller) {
                  userMapViewModel.setController(controller: controller);
                },
                onMapTapped: (point, latLng) => userMapViewModel.toggleMarker(),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: userMapViewModel.isMarkerClicked.value
                    ? 0
                    : -200, // 보일 때는 0, 사라질 때는 -200
                left: 0,
                right: 0,
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const DetailPage());
                  },
                  child: PageView(
                    controller: userMapViewModel.pageController,
                    onPageChanged: (page) {
                      userMapViewModel.selectedPage.value = page;
                    },
                    children: List.generate(
                      2,
                      (index) {
                        return const UserShopCardVIew();
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
