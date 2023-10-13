// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/train_company.dart';
import '../../state/train_station/train_station_notifier.dart';

class StationSelectAlert extends ConsumerWidget {
  StationSelectAlert({super.key, required this.train});

  final Train train;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

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
              Text(train.trainName),
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
