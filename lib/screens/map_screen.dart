import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../state/app_state/app_notifier.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';
import '../state/train_station/train_station_notifier.dart';
import '../utility/utility.dart';

// ignore: must_be_immutable
class MapScreen extends ConsumerWidget {
  MapScreen({super.key});

  final Utility _utility = Utility();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  late CameraPosition _initialCameraPosition;

  LatLngBounds _pinpointMapBounds = LatLngBounds(southwest: const LatLng(0, 0), northeast: const LatLng(0, 0));

  late Set<Marker> markers;

  Set<Polyline> polylineSet = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    _setInitialCameraPosition();

    _getLocation();

    _makeBounds();

    final latLngState = ref.watch(latLngProvider);

    final selectedTrainStation = ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

    final distance = ref.watch(appProvider.select((value) => value.distance));

    //==============================
    markers = {
      Marker(
        markerId: const MarkerId('here'),
        position: LatLng(latLngState.lat, latLngState.lng),
        infoWindow: const InfoWindow(title: 'title', snippet: 'snippet'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ),
    };

    final circleCenter = <String, double>{};

    if (selectedTrainStation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('station'),
          position: LatLng(selectedTrainStation.lat.toDouble(), selectedTrainStation.lng.toDouble()),
          infoWindow: const InfoWindow(title: 'title', snippet: 'snippet'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      //////////////////////////////////

      polylineSet.add(
        Polyline(
          polylineId: const PolylineId('Here_and_Station'),
          color: Colors.redAccent,
          width: 5,
          points: <LatLng>[
            LatLng(latLngState.lat, latLngState.lng),
            LatLng(selectedTrainStation.lat.toDouble(), selectedTrainStation.lng.toDouble()),
          ],
        ),
      );

      //////////////////////////////////

      circleCenter['lat'] = selectedTrainStation.lat.toDouble();
      circleCenter['lng'] = selectedTrainStation.lng.toDouble();
    }

    //==============================

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              markers: markers,
              polylines: polylineSet,
              onMapCreated: (GoogleMapController gmcontroller) {
                _mapController.complete(gmcontroller);
                _fitMapBounds();
              },
              circles: {
                if (circleCenter['lat'] != null)
                  Circle(
                    circleId: const CircleId('Circle1'),
                    //一意なID
                    center: LatLng(circleCenter['lat']!, circleCenter['lng']!),
                    //中心の座標
                    radius: 300,
                    //半径(m)
                    strokeColor: Colors.pink.withOpacity(0.8),
                    //線の色
                    fillColor: Colors.pink.withOpacity(0.2),
                    //塗りつぶし色
                    strokeWidth: 2, //線の太さ
                  )
              },
              zoomControlsEnabled: false,
            ),
            Column(
              children: [
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
                Expanded(child: Container()),
                Container(
                  width: context.screenSize.width,
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      CircularCountDownTimer(
                        duration: 10,
                        width: context.screenSize.width / 10,
                        height: context.screenSize.height / 10,
                        ringColor: Colors.blueAccent,
                        fillColor: Colors.white,
                        onComplete: _goHomeScreen,
                        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            const Text('現在位置'),
                            Container(
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Text('${latLngState.lat} / ${latLngState.lng}'),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            if (selectedTrainStation != null) ...[
                              const SizedBox(height: 10),
                              const Text('目的地'),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Text(selectedTrainStation.stationName),
                                    Text(selectedTrainStation.lineName),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Text(
                                  '$distance Km',
                                  style: const TextStyle(fontSize: 20, color: Colors.yellowAccent),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  Future<void> _getLocation() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final param = LatLngRequestState(lat: position.latitude, lng: position.longitude);

    await _ref.read(latLngProvider.notifier).setLatLng(param: param);

    //////////////////////////////////////

    final selectedTrainStation = _ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

    final distance = (selectedTrainStation == null)
        ? '0'
        : _utility.calcDistance(
            originLat: position.latitude,
            originLng: position.longitude,
            destLat: selectedTrainStation.lat.toDouble(),
            destLng: selectedTrainStation.lng.toDouble(),
          );

    await _ref.read(appProvider.notifier).setDistance(distance: distance);

    //////////////////////////////////////
  }

  ///
  void _setInitialCameraPosition() {
    final latLngState = _ref.watch(latLngProvider);
    final latLng = LatLng(latLngState.lat, latLngState.lng);
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 15, tilt: 50);
  }

  ///
  Future<void> _fitMapBounds() async {
    final googleMap = await _mapController.future;

    // ignore: use_build_context_synchronously
    await googleMap.moveCamera(CameraUpdate.newLatLngBounds(_pinpointMapBounds, _context.screenSize.width * 0.2));
  }

  ///
  void _makeBounds() {
    final latList = <double>[];
    final lngList = <double>[];

    final latLngState = _ref.watch(latLngProvider);
    latList.add(latLngState.lat);
    lngList.add(latLngState.lng);

    final selectedTrainStation = _ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

    if (selectedTrainStation != null) {
      latList.add(selectedTrainStation.lat.toDouble());
      lngList.add(selectedTrainStation.lng.toDouble());
    }

    final minLat = latList.reduce(min);
    final maxLat = latList.reduce(max);
    final minLng = lngList.reduce(min);
    final maxLng = lngList.reduce(max);

    _pinpointMapBounds = LatLngBounds(northeast: LatLng(maxLat, maxLng), southwest: LatLng(minLat, minLng));
  }

  ///
  void _goHomeScreen() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => MapScreen()));
}
