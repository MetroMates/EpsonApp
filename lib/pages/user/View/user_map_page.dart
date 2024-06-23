import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/user/Controller/user_map_viewmodel.dart';
import 'package:epson_app/pages/user/View/navar_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class UserMapPage extends StatelessWidget {
  const UserMapPage({super.key});

  @override
<<<<<<< HEAD
  Widget build(BuildContext context) {
=======
  State<NaverMapView> createState() => _NaverMapViewState();
}

class _NaverMapViewState extends State<NaverMapView> {
  final UserMapViewModel userMapViewModel =
      GetxManager.instance<UserMapViewModel>();

  @override
  Widget build(BuildContext context) {
    // 최초에 setCenter() 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userMapViewModel.setCenter();
    });

>>>>>>> feat/swj
    return Scaffold(
      appBar: AppBar(
        title: Text('map'.tr),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          )
        ],
      ),
      body: const NaverMapView(),
    );
  }
}
