// ignore_for_file: must_be_immutable, depend_on_referenced_packages, deprecated_member_use

import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
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

  late Set<Marker> markers;

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

    final now = DateTime.now();
    final timeFormat = DateFormat('HH:mm:ss');
    final currentTime = timeFormat.format(now);

    //==============================
    markers = {
      Marker(
        markerId: const MarkerId('here'),
        position: LatLng(latLngState.lat, latLngState.lng),
        infoWindow: const InfoWindow(title: 'title', snippet: 'snippet'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ),
    };

    if (selectedTrainStation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('station'),
          position: LatLng(selectedTrainStation!.lat.toDouble(), selectedTrainStation!.lng.toDouble()),
          infoWindow: const InfoWindow(title: 'title', snippet: 'snippet'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        ),
      );
    }

    //==============================

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //=======================================
            GoogleMap(
              onMapCreated: mapController.complete,
              initialCameraPosition: initialCameraPosition,
              markers: markers,
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
  Future<void> getLocation() async {
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
  }

  ///
  void setMapParam() {
    final latLngState = _ref.watch(latLngProvider);
    final latLng = LatLng(latLngState.lat, latLngState.lng);
    initialCameraPosition = CameraPosition(target: latLng, zoom: 15, tilt: 50);
  }
}
