// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:konoeki_de_oritimer/extensions/extensions.dart';
// import 'package:latlong2/latlong.dart';
//
// import '../models/train_station.dart';
// import '../state/lat_lng/lat_lng_notifier.dart';
// import '../state/lat_lng/lat_lng_request_state.dart';
// import '../utility/utility.dart';
//
// // ignore: must_be_immutable
// class MapScreen extends ConsumerWidget {
//   MapScreen({super.key, required this.trainStation});
//
//   final TrainStation trainStation;
//
//   final Utility _utility = Utility();
//
//   TrainStation? selectedTrainStation;
//
//   double boundsLatLngDiffSmall = 0;
//
//   double boundsInner = 0;
//
//   Map<String, double> boundsLatLngMap = {};
//
//   late Position currentPosition;
//
//   late BuildContext _context;
//   late WidgetRef _ref;
//
//   ///
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     _context = context;
//     _ref = ref;
//
//     getLocation();
//
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             (boundsInner == 0)
//                 ? Container(
//                     child: Text('aa'),
//                   )
//                 : FlutterMap(
//                     options: MapOptions(
//                       bounds: LatLngBounds(
//                         LatLng(boundsLatLngMap['minLat']! - boundsInner, boundsLatLngMap['minLng']! - boundsInner),
//                         LatLng(boundsLatLngMap['maxLat']! + boundsInner, boundsLatLngMap['maxLng']! + boundsInner),
//                       ),
//                     ),
//                     children: [
//                       TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
// //                MarkerLayer(markers: markerList),
//                     ],
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   ///
//   Future<void> getLocation() async {
//     var permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//     //==============================
//     final latList = <double>[];
//     final lngList = <double>[];
//
//     latList.add(currentPosition.latitude);
//     lngList.add(currentPosition.longitude);
//
//     latList.add(trainStation.lat.toDouble());
//     lngList.add(trainStation.lng.toDouble());
//
//     final minLat = latList.reduce(min);
//     final maxLat = latList.reduce(max);
//     final minLng = lngList.reduce(min);
//     final maxLng = lngList.reduce(max);
//
//     final latDiff = maxLat - minLat;
//     final lngDiff = maxLng - minLng;
//     boundsLatLngDiffSmall = (latDiff < lngDiff) ? latDiff : lngDiff;
//     boundsInner = boundsLatLngDiffSmall * 0.2;
//
//     boundsLatLngMap = {'minLat': minLat, 'maxLat': maxLat, 'minLng': minLng, 'maxLng': maxLng};
//
//     print(boundsLatLngMap);
//
//     //==============================
//
//     final param = LatLngRequestState(lat: currentPosition.latitude, lng: currentPosition.longitude);
//
//     await _ref.read(latLngProvider.notifier).setLatLng(param: param);
//   }
// }
//
// // // ignore_for_file: must_be_immutable, depend_on_referenced_packages, deprecated_member_use
// //
// // import 'dart:async';
// // import 'dart:math';
// //
// // import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:hooks_riverpod/hooks_riverpod.dart';
// // import 'package:intl/intl.dart';
// //
// // import 'package:latlong2/latlong.dart';
// //
// // import '../extensions/extensions.dart';
// // import '../models/train_station.dart';
// // import '../state/lat_lng/lat_lng_notifier.dart';
// // import '../state/lat_lng/lat_lng_request_state.dart';
// // import '../state/train_station/train_station_notifier.dart';
// // import '../utility/utility.dart';
// //
// // class MapScreen extends ConsumerWidget {
// //   MapScreen({super.key});
// //
// //   final Utility _utility = Utility();
// //
// //   TrainStation? selectedTrainStation;
// //
// //   double boundsLatLngDiffSmall = 0;
// //
// //   late double boundsInner;
// //
// //   Map<String, double> boundsLatLngMap = {};
// //
// //   late BuildContext _context;
// //   late WidgetRef _ref;
// //
// //   ///
// //   void _goHomeScreen() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => MapScreen()));
// //
// //   ///
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     _context = context;
// //     _ref = ref;
// //
// //     getLocation();
// //
// //     final latLngState = ref.watch(latLngProvider);
// //
// //     selectedTrainStation = ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));
// //
// //     var distance = '';
// //
// //     if (selectedTrainStation != null && selectedTrainStation!.lat != '') {
// //       distance = _utility.calcDistance(
// //         originLat: latLngState.lat,
// //         originLng: latLngState.lng,
// //         destLat: selectedTrainStation!.lat.toDouble(),
// //         destLng: selectedTrainStation!.lng.toDouble(),
// //       );
// //     }
// //
// //     /*
// //
// //
// //
// //
// //     setMapParam();
// //
// //     //==============================
// //     markers = {
// //       Marker(
// //         markerId: const MarkerId('here'),
// //         position: LatLng(latLngState.lat, latLngState.lng),
// //         infoWindow: const InfoWindow(title: 'title', snippet: 'snippet'),
// //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
// //       ),
// //     };
// //
// //     if (selectedTrainStation != null) {
// //       markers.add(
// //         Marker(
// //           markerId: const MarkerId('station'),
// //           position: LatLng(selectedTrainStation!.lat.toDouble(), selectedTrainStation!.lng.toDouble()),
// //           infoWindow: const InfoWindow(title: 'title', snippet: 'snippet'),
// //           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
// //         ),
// //       );
// //     }
// //
// //     //==============================
// //
// //     _displayPinpointMapBounds();
// //
// //
// //
// //
// //
// //     */
// //
// //     final now = DateTime.now();
// //     final timeFormat = DateFormat('HH:mm:ss');
// //     final currentTime = timeFormat.format(now);
// //
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Stack(
// //           children: [
// //             // //=======================================
// //             // GoogleMap(
// //             //   onMapCreated: mapController.complete,
// //             //   initialCameraPosition: initialCameraPosition,
// //             //   markers: markers,
// //             //   zoomControlsEnabled: false,
// //             // ),
// //             // //=======================================
// //             //
// //             //
// //             //
// //             //
// //
// //             FlutterMap(
// //               options: MapOptions(
// //                 bounds: LatLngBounds(
// //                   LatLng(boundsLatLngMap['minLat']! - boundsInner, boundsLatLngMap['minLng']! - boundsInner),
// //                   LatLng(boundsLatLngMap['maxLat']! + boundsInner, boundsLatLngMap['maxLng']! + boundsInner),
// //                 ),
// //               ),
// //               children: [
// //                 TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
// // //                MarkerLayer(markers: markerList),
// //               ],
// //             ),
// //
// //             Container(
// //               width: context.screenSize.width,
// //               decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   const Text('MapScreen'),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Container(),
// //                       IconButton(
// //                         onPressed: () => Navigator.pop(context),
// //                         icon: const Icon(
// //                           Icons.close,
// //                           color: Colors.redAccent,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 10),
// //                   Text(latLngState.lat.toString()),
// //                   Text(latLngState.lng.toString()),
// //                   const SizedBox(height: 40),
// //                   if (selectedTrainStation != null) ...[
// //                     Text(selectedTrainStation!.stationName),
// //                     Text(selectedTrainStation!.address),
// //                     Text(selectedTrainStation!.lat),
// //                     Text(selectedTrainStation!.lng),
// //                     Text(selectedTrainStation!.lineNumber),
// //                     Text(selectedTrainStation!.lineName),
// //                   ],
// //                   const SizedBox(height: 10),
// //                   Text(distance),
// //                   const SizedBox(height: 10),
// //                   Text(currentTime),
// //                   const SizedBox(height: 40),
// //                   CircularCountDownTimer(
// //                     duration: 10,
// //                     width: context.screenSize.width / 10,
// //                     height: context.screenSize.height / 10,
// //                     ringColor: Colors.blueAccent,
// //                     fillColor: Colors.white,
// //                     onComplete: _goHomeScreen,
// //                     textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   ///
// //   Future<void> getLocation() async {
// //     var permission = await Geolocator.checkPermission();
// //
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //
// //       if (permission == LocationPermission.denied) {
// //         return Future.error('Location permissions are denied');
// //       }
// //     }
// //
// //     final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //
// //     //==============================
// //     final latList = <double>[];
// //     final lngList = <double>[];
// //
// //     latList.add(position.latitude);
// //     lngList.add(position.longitude);
// //
// //     selectedTrainStation = _ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));
// //
// //     if (selectedTrainStation != null) {
// //       latList.add(selectedTrainStation!.lat.toDouble());
// //       lngList.add(selectedTrainStation!.lng.toDouble());
// //     }
// //
// //     final minLat = latList.reduce(min);
// //     final maxLat = latList.reduce(max);
// //     final minLng = lngList.reduce(min);
// //     final maxLng = lngList.reduce(max);
// //
// //     final latDiff = maxLat - minLat;
// //     final lngDiff = maxLng - minLng;
// //     boundsLatLngDiffSmall = (latDiff < lngDiff) ? latDiff : lngDiff;
// //     boundsInner = boundsLatLngDiffSmall * 0.2;
// //
// //     boundsLatLngMap = {'minLat': minLat, 'maxLat': maxLat, 'minLng': minLng, 'maxLng': maxLng};
// //
// //     //==============================
// //
// //     final param = LatLngRequestState(lat: position.latitude, lng: position.longitude);
// //
// //     await _ref.read(latLngProvider.notifier).setLatLng(param: param);
// //   }
// //
// // /*
// //
// //
// //
// //
// //
// //
// //   ///
// //   Future<void> getLocation() async {
// //     var permission = await Geolocator.checkPermission();
// //
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //
// //       if (permission == LocationPermission.denied) {
// //         return Future.error('Location permissions are denied');
// //       }
// //     }
// //
// //     final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //
// //     //==============================
// //     final latList = <double>[];
// //     final lngList = <double>[];
// //
// //     latList.add(position.latitude);
// //     lngList.add(position.longitude);
// //
// //     selectedTrainStation = _ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));
// //
// //     if (selectedTrainStation != null) {
// //       latList.add(selectedTrainStation!.lat.toDouble());
// //       lngList.add(selectedTrainStation!.lng.toDouble());
// //     }
// //
// //     final minLat = latList.reduce(min);
// //     final maxLat = latList.reduce(max);
// //     final minLng = lngList.reduce(min);
// //     final maxLng = lngList.reduce(max);
// //
// //     pinpointMapBounds = LatLngBounds(northeast: LatLng(maxLat, maxLng), southwest: LatLng(minLat, minLng));
// //
// //     //==============================
// //
// //     final param = LatLngRequestState(lat: position.latitude, lng: position.longitude);
// //
// //     await _ref.read(latLngProvider.notifier).setLatLng(param: param);
// //   }
// //
// //   ///
// //   void setMapParam() {
// //     final latLngState = _ref.watch(latLngProvider);
// //     final latLng = LatLng(latLngState.lat, latLngState.lng);
// //     initialCameraPosition = CameraPosition(target: latLng, zoom: 15, tilt: 50);
// //   }
// //
// //   ///
// //   Future<void> _displayPinpointMapBounds() async {
// //     final googleMap = await mapController.future;
// //     await googleMap.animateCamera(CameraUpdate.newLatLngBounds(pinpointMapBounds, 50));
// //   }
// //
// //
// //
// //
// //
// //
// //   */
// // }
