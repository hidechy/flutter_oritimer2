// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/train_company.dart';
import '../../state/app_state/app_notifier.dart';
import '../../state/lat_lng/lat_lng_notifier.dart';
import '../../state/train_station/train_station_notifier.dart';
import '../../utility/utility.dart';

class StationSelectAlert extends ConsumerWidget {
  StationSelectAlert({super.key, required this.train});

  final Train train;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final prefecture = ref.watch(appProvider.select((value) => value.selectPrefecture));

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(train.trainName),
                  Text('（$prefecture）'),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: displayStation()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayStation() {
    final list = <Widget>[];

    if (train.trainNumber != '') {
      final latLngState = _ref.watch(latLngProvider);

      final selectedTrainStation = _ref.watch(trainStationProvider.select((value) => value.selectedTrainStation));

      _ref.watch(trainStationProvider.select((value) => value.stationList)).forEach((element) {
        list.add(Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(element.stationName),
                  Text(element.address),
                  Text('${element.lat} / ${element.lng}', style: const TextStyle(fontSize: 8)),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  await _ref.read(trainStationProvider.notifier).setSelectedTrainStation(station: element);

                  final distance = _utility.calcDistance(
                    originLat: latLngState.lat,
                    originLng: latLngState.lng,
                    destLat: element.lat.toDouble(),
                    destLng: element.lng.toDouble(),
                  );

                  await _ref.read(appProvider.notifier).setDistance(distance: distance);

                  Navigator.pop(_context);

                  Navigator.pop(_context);
                },
                child: Icon(
                  Icons.input,
                  size: 20,
                  color: (selectedTrainStation != null && selectedTrainStation.stationName == element.stationName)
                      ? Colors.blueAccent
                      : Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ));
      });
    }

    return SingleChildScrollView(
      child: DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list)),
    );
  }
}
