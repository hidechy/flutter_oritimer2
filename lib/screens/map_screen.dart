// ignore_for_file: must_be_immutable, depend_on_referenced_packages, deprecated_member_use

import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../extensions/extensions.dart';
import '../models/train_station.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';
import '../state/train_station/train_station_notifier.dart';
import '../utility/utility.dart';

class MapScreen extends ConsumerWidget {
  MapScreen({super.key});

  List<Marker> markerList = [];

  final Utility _utility = Utility();

  TrainStation? selectedTrainStation;

  late CameraPosition initialCameraPosition;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  LatLngBounds pinpointMapBounds = LatLngBounds(southwest: const LatLng(0, 0), northeast: const LatLng(0, 0));

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  void _goHomeScreen() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => MapScreen()));

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    getLocation();

    final latLngState = ref.watch(latLngProvider);

    selectedTrainStation = ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

    var distance = '';

    if (selectedTrainStation != null && selectedTrainStation!.lat != '') {
      distance = _utility.calcDistance(
        originLat: latLngState.lat,
        originLng: latLngState.lng,
        destLat: selectedTrainStation!.lat.toDouble(),
        destLng: selectedTrainStation!.lng.toDouble(),
      );
    }

    setMapParam();

    makeBounds();

    final now = DateTime.now();
    final timeFormat = DateFormat('HH:mm:ss');
    final currentTime = timeFormat.format(now);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //=======================================
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: initialCameraPosition,
              // markers: markers,
              // polylines: polylineSet,
              zoomControlsEnabled: false,
            ),
            //=======================================

            Container(
              width: context.screenSize.width,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('MapScreen'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(latLngState.lat.toString()),
                  Text(latLngState.lng.toString()),
                  const SizedBox(height: 40),
                  if (selectedTrainStation != null) ...[
                    Text(selectedTrainStation!.stationName),
                    Text(selectedTrainStation!.address),
                    Text(selectedTrainStation!.lat),
                    Text(selectedTrainStation!.lng),
                    Text(selectedTrainStation!.lineNumber),
                    Text(selectedTrainStation!.lineName),
                  ],
                  const SizedBox(height: 10),
                  Text(distance),
                  const SizedBox(height: 10),
                  Text(currentTime),
                  const SizedBox(height: 40),
                  CircularCountDownTimer(
                    duration: 10,
                    width: context.screenSize.width / 10,
                    height: context.screenSize.height / 10,
                    ringColor: Colors.blueAccent,
                    fillColor: Colors.white,
                    onComplete: _goHomeScreen,
                    textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  void _onMapCreated(GoogleMapController controller) {
    mapController = Completer();

    makeBounds();
  }

  ///
  Future<void> makeBounds() async {
    final latList = <double>[];
    final lngList = <double>[];

    final latLngState = _ref.watch(latLngProvider);

    latList.add(latLngState.lat);
    lngList.add(latLngState.lng);

    selectedTrainStation = await _ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

    if (selectedTrainStation != null) {
      latList.add(selectedTrainStation!.lat.toDouble());
      lngList.add(selectedTrainStation!.lng.toDouble());
    }

    final minLat = latList.reduce(min);
    final maxLat = latList.reduce(max);
    final minLng = lngList.reduce(min);
    final maxLng = lngList.reduce(max);

    pinpointMapBounds = LatLngBounds(northeast: LatLng(maxLat, maxLng), southwest: LatLng(minLat, minLng));

    await _displayPinpointMapBounds();
  }

  ///
  Future<void> _displayPinpointMapBounds() async {
    final googleMap = await mapController.future;
    await googleMap.animateCamera(CameraUpdate.newLatLngBounds(pinpointMapBounds, 50));
  }

  ///
  Future<void> getLocation() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // debugPrint('緯度: ${position.latitude}');
    // debugPrint('経度: ${position.longitude}');

    final param = LatLngRequestState(lat: position.latitude, lng: position.longitude);

    await _ref.read(latLngProvider.notifier).setLatLng(param: param);

/*
    //

    // 高度
    debugPrint('高度: ${position.altitude}');

    //

    final exFunabashi = funabashi.split(',');
    final exZenpukuji = zenpukuji.split(',');

    // 距離をメートルで返す
    final distanceInMeters = Geolocator.distanceBetween(
      exFunabashi[0].toDouble(),
      exFunabashi[1].toDouble(),
      exZenpukuji[0].toDouble(),
      exZenpukuji[1].toDouble(),
    );

    debugPrint('距離:$distanceInMeters');

    // 方位を返す
    final bearing = Geolocator.bearingBetween(
      exFunabashi[0].toDouble(),
      exFunabashi[1].toDouble(),
      exZenpukuji[0].toDouble(),
      exZenpukuji[1].toDouble(),
    );

    debugPrint('方位:$bearing');
    */
  }

  // ///
  // Future<void> _makeMarker() async {
  //   markerList = [];
  //
  //   final latLngState = _ref.watch(latLngProvider);
  //
  //   markerList.add(
  //     Marker(
  //       point: LatLng(latLngState.lat, latLngState.lng),
  //       child: CircleAvatar(
  //         backgroundColor: Colors.orangeAccent.withOpacity(0.4),
  //         child: const Text(
  //           'Here',
  //           style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  //

  ///
  void setMapParam() {
    // final pinpointMapZoom = _ref.watch(mapPinpointProvider.select((value) => value.pinpointMapZoom));
    //
    // final latLng = LatLng(geolocList[0].latitude.toDouble(), geolocList[0].longitude.toDouble());
    // initialCameraPosition = CameraPosition(target: latLng, zoom: pinpointMapZoom.toDouble(), tilt: 50);
    //
    //
    //

    final latLngState = _ref.watch(latLngProvider);
    final latLng = LatLng(latLngState.lat, latLngState.lng);
    initialCameraPosition = CameraPosition(target: latLng, zoom: 15, tilt: 50);
  }
}
