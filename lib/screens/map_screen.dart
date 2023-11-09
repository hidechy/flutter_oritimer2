import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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

    final now = DateTime.now();
    final timeFormat = DateFormat('HH:mm:ss');
    final currentTime = timeFormat.format(now);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController gmcontroller) {
                _mapController.complete(gmcontroller);
                _fitMapBounds();
              },
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
                const SizedBox(height: 10),
                Text(latLngState.lat.toString()),
                Text(latLngState.lng.toString()),
                const SizedBox(height: 40),
                if (selectedTrainStation != null) ...[
                  Text(selectedTrainStation.stationName),
                  Text(selectedTrainStation.address),
                  Text(selectedTrainStation.lat),
                  Text(selectedTrainStation.lng),
                  Text(selectedTrainStation.lineNumber),
                  Text(selectedTrainStation.lineName),
                ],
                const SizedBox(height: 10),
                Text(distance),
                const SizedBox(height: 10),
                Text(currentTime),
                const SizedBox(height: 40),
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
    await googleMap.moveCamera(CameraUpdate.newLatLngBounds(_pinpointMapBounds, _context.screenSize.width * 0.1));
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
}
