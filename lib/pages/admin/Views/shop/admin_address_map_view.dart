import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

// class AdminAddressMapView extends StatelessWidget {
//   const AdminAddressMapView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return NaverMap(
//       forceGesture: true,
//       options: NaverMapViewOptions(
//         initialCameraPosition: NCameraPosition(
//           target: userMapViewModel.initialCenter.value!,
//           zoom: 14.2,
//         ),
//         activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
//         locationButtonEnable: true,
//       ),
//       onMapReady: (controller) {
//         userMapViewModel.setController(controller: controller);
//       },
//       onMapTapped: (point, latLng) => userMapViewModel.toggleMarker(),
//     );
//   }
// }
