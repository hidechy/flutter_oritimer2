// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:konoeki_de_oritimer/state/app_state/app_notifier.dart';
import 'package:konoeki_de_oritimer/state/lat_lng/lat_lng_notifier.dart';
import 'package:konoeki_de_oritimer/state/lat_lng/lat_lng_request_state.dart';

import '../extensions/extensions.dart';
import '../models/train_station.dart';
import '../state/train_company/train_company_notifier.dart';
import '../state/train_station/train_station_notifier.dart';
import 'alert/_oritimer_dialog.dart';
import 'alert/train_select_alert.dart';
import 'map_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  TrainStation? selectedTrainStation;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    selectedTrainStation = ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

    var appState = ref.watch(appProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                await ref.read(latLngProvider.notifier).setLatLng(param: LatLngRequestState(lat: 0, lng: 0));
                //
                // await ref.read(trainCompanyProvider.notifier).setSelectedCompanyName(selectedCompanyName: '');
                // await ref.read(trainCompanyProvider.notifier).setSelectedTrainNumber(selectedTrainNumber: '');

                await ref.read(trainStationProvider.notifier).setSelectedTrainStation(
                      station: TrainStation(
                          id: 0, stationName: '', address: '', lat: '', lng: '', lineNumber: '', lineName: ''),
                    );

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text('初期化'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref.watch(appProvider.notifier).setErrorMsg(msg: '');

                await OritimerDialog(
                  context: context,
                  widget: TrainSelectAlert(),
                );
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (selectedTrainStation == null || selectedTrainStation!.stationName == '') {
                  ref.read(appProvider.notifier).setErrorMsg(msg: '目的の駅が選択されていません。');
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
                }
              },
              child: const Text('click'),
            ),
            if (appState.errorMsg != '')
              Text(
                appState.errorMsg,
                style: TextStyle(color: Colors.yellowAccent, fontSize: 10),
              ),
          ],
        ),
      ),
    );
  }
}
