// ignore_for_file: must_be_immutable, depend_on_referenced_packages, deprecated_member_use

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../extensions/extensions.dart';
import '../models/train_station.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';
import '../utility/utility.dart';

class MapScreen extends ConsumerWidget {
  MapScreen({super.key});

  List<Marker> markerList = [];

  final Utility _utility = Utility();

  TrainStation? selectedTrainStation;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  void _goHomeScreen() => Navigator.pushReplacement(
      _context, MaterialPageRoute(builder: (context) => MapScreen()));

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final now = DateTime.now();
    final timeFormat = DateFormat('HH:mm:ss');
    final currentTime = timeFormat.format(now);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('MapScreen'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CircularCountDownTimer(
              duration: 10,
              width: context.screenSize.width / 10,
              height: context.screenSize.height / 10,
              ringColor: Colors.blueAccent,
              fillColor: Colors.white,
              onComplete: _goHomeScreen,
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    /*








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

    _makeMarker();

    final now = DateTime.now();
    final timeFormat = DateFormat('HH:mm:ss');
    final currentTime = timeFormat.format(now);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 10),

            //---------------------------------------------
            Expanded(
              child: (latLngState.lat > 0 && latLngState.lng > 0)
                  ? FlutterMap(
                      options: MapOptions(
                        center: LatLng(latLngState.lat, latLngState.lng),
                        zoom: 16,
                        maxZoom: 17,
                        minZoom: 3,
                      ),
                      children: [
                        TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                        MarkerLayer(markers: markerList),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 20),
                          Text('Now Map Calling..'),
                        ],
                      ),
                    ),
            ),
            //---------------------------------------------

            const SizedBox(height: 20),

            Container(
              width: context.screenSize.width,
              height: 70,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 10),
                child: Row(
                  children: [
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(DateTime.now().yyyymmdd),
                            const SizedBox(width: 10),
                            Text(currentTime),
                          ],
                        ),
                        Row(
                          children: [
                            Text(latLngState.lat.toString()),
                            const Text(' / '),
                            Text(
                              latLngState.lng.toString(),
                            )
                          ],
                        ),
                        Text('$distance Km'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );





    */
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

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // debugPrint('緯度: ${position.latitude}');
    // debugPrint('経度: ${position.longitude}');

    final param =
        LatLngRequestState(lat: position.latitude, lng: position.longitude);

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

  ///
  Future<void> _makeMarker() async {
    markerList = [];

    final latLngState = _ref.watch(latLngProvider);

    markerList.add(
      Marker(
        point: LatLng(latLngState.lat, latLngState.lng),
        child: CircleAvatar(
          backgroundColor: Colors.orangeAccent.withOpacity(0.4),
          child: const Text(
            'Here',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
