// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final selectedTrainNumber = ref.watch(trainCompanyProvider.select((value) => value.selectedTrainNumber));

    if (selectedTrainNumber != '') {
      selectedTrainStation =
          ref.watch(trainStationProvider(selectedTrainNumber).select((value) => value.selectedTrainStation));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                OritimerDialog(
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
              child: (selectedTrainStation == null)
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
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen())),
              child: const Text('click'),
            ),
          ],
        ),
      ),
    );
  }
}
