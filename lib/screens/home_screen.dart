// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/train_station.dart';
import '../state/app_state/app_notifier.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';
import '../state/train_station/train_station_notifier.dart';
import '../utility/utility.dart';
import 'alert/_oritimer_dialog.dart';
import 'alert/train_select_alert.dart';
import 'map_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final Utility _utility = Utility();

  TrainStation? selectedTrainStation;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final appState = ref.watch(appProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                await ref.read(latLngProvider.notifier).setLatLng(param: const LatLngRequestState());

                await ref.read(trainStationProvider.notifier).setSelectedTrainStation(
                      station: TrainStation(
                          id: 0, stationName: '', address: '', lat: '', lng: '', lineNumber: '', lineName: ''),
                    );

                await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: const Text('初期化'),
            ),
            const SizedBox(height: 20),
            const Text('現在地点'),
            Container(
              width: context.screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.2)),
              child: Text('${latLngState.lat} / ${latLngState.lng}', style: const TextStyle(fontSize: 10)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref.watch(appProvider.notifier).setErrorMsg(msg: '');

                await OritimerDialog(context: context, widget: TrainSelectAlert());
              },
              child: const Text('station'),
            ),
            Container(
              width: context.screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.2)),
              child: (selectedTrainStation == null || selectedTrainStation!.stationName == '')
                  ? Container()
                  : DefaultTextStyle(
                      style: const TextStyle(fontSize: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selectedTrainStation!.stationName),
                          Text(selectedTrainStation!.address),
                          Text(
                            '${selectedTrainStation!.lat} / ${selectedTrainStation!.lng}',
                            style: const TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
            ),
            if (distance != '') ...[
              const SizedBox(height: 10),
              Container(
                width: context.screenSize.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.2)),
                child: Text(distance, style: const TextStyle(fontSize: 10)),
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (selectedTrainStation == null || selectedTrainStation!.stationName == '') {
                  ref.read(appProvider.notifier).setErrorMsg(msg: '目的の駅が選択されていません。');
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
                }
              },
              child: const Text('map'),
            ),
            if (appState.errorMsg != '')
              Text(
                appState.errorMsg,
                style: const TextStyle(color: Colors.yellowAccent, fontSize: 10),
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
}
