import 'package:epson_app/pages/user/View/map/navar_map_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMapPage extends StatelessWidget {
  const UserMapPage({super.key});

  @override
  Widget build(BuildContext context) {
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
