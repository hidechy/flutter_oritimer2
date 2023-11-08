import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../extensions/extensions.dart';
import '../models/train_station.dart';
import '../state/app_state/app_notifier.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';
import '../state/train_station/train_station_notifier.dart';
import '../utility/utility.dart';

// ignore: must_be_immutable
class MapScreen extends ConsumerWidget {
  MapScreen({super.key, required this.trainStation});

  final TrainStation trainStation;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    getLocation();

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
}
