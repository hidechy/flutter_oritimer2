import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../state/app_state/app_notifier.dart';
import '../state/area_prefecture/area_prefecture_notifier.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';
import '../state/train_station/train_station_notifier.dart';
import 'alert/_oritimer_dialog.dart';
import 'alert/train_select_alert.dart';
import 'map_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  List<String> areaNameList = ['北海道・東北', '関東', '中部', '近畿', '中国', '四国', '九州・沖縄'];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    _getLocation();

    final latLngState = ref.watch(latLngProvider);

    final selectedTrainStation = ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

    final appState = ref.watch(appProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('現在地点'),
              Container(
                width: context.screenSize.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.2)),
                child: Text('${latLngState.lat} / ${latLngState.lng}', style: const TextStyle(fontSize: 10)),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: () => _ref.read(appProvider.notifier).setAreaAndPrefecture(area: '', prefecture: ''),
                    child: const Text('clear'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _areaPrefectureList(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await ref.watch(appProvider.notifier).setErrorMsg(msg: '');

                  // ignore: use_build_context_synchronously
                  await OritimerDialog(context: context, widget: TrainSelectAlert());
                },
                child: const Text('station'),
              ),
              Container(
                width: context.screenSize.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.2)),
                child: (selectedTrainStation == null || selectedTrainStation.stationName == '')
                    ? Container()
                    : DefaultTextStyle(
                        style: const TextStyle(fontSize: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(selectedTrainStation.stationName),
                            Text(selectedTrainStation.address),
                            Text(
                              '${selectedTrainStation.lat} / ${selectedTrainStation.lng}',
                              style: const TextStyle(fontSize: 8),
                            ),
                            if (appState.distance != '') Text(appState.distance),
                          ],
                        ),
                      ),
              ),
              if (appState.distance != '') ...[
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen())),
                  child: const Text('map'),
                ),
              ],
            ],
          ),
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
  }

  ///
  Widget _areaPrefectureList() {
    final list = <Widget>[];

    final areaPrefectureState = _ref.watch(areaPrefectureProvider);

    final appState = _ref.watch(appProvider);

    areaNameList.forEach((element) {
      if (areaPrefectureState.areaPrefectureMap[element] != null) {
        list.add(
          ExpansionTile(
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            title: Text(
              element,
              style: TextStyle(
                color: (appState.selectArea == element) ? Colors.yellowAccent : Colors.white,
                fontSize: 12,
              ),
            ),
            children: areaPrefectureState.areaPrefectureMap[element]!.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.prefecture,
                      style: TextStyle(
                        color: (appState.selectPrefecture == e.prefecture) ? Colors.yellowAccent : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _ref
                            .read(appProvider.notifier)
                            .setAreaAndPrefecture(area: element, prefecture: e.prefecture);

                        await _ref
                            .read(areaPrefectureProvider.notifier)
                            .getAreaPrefectureCompany(prefecture: e.prefecture);
                      },
                      icon: const Icon(Icons.navigate_next, color: Colors.white),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }

      list.add(const SizedBox(height: 10));
    });

    return SingleChildScrollView(child: Column(children: list));
  }
}
