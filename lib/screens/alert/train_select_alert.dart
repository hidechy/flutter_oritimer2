// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:konoeki_de_oritimer/screens/alert/_oritimer_dialog.dart';
import 'package:konoeki_de_oritimer/screens/alert/station_select_alert.dart';
import 'package:konoeki_de_oritimer/state/train_station/train_station_notifier.dart';

import '../../extensions/extensions.dart';
import '../../state/area_prefecture/area_prefecture_notifier.dart';
import '../../state/train_company/train_company_notifier.dart';

class TrainSelectAlert extends ConsumerWidget {
  TrainSelectAlert({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Company'),
                  GestureDetector(
                    onTap: () =>
                        _ref.read(trainCompanyProvider.notifier).setSelectedCompanyName(selectedCompanyName: ''),
                    child: const Text('clear'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: context.screenSize.width,
                height: context.screenSize.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.35)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: displayTrainCompany(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Train'),
                  GestureDetector(
                    onTap: () =>
                        _ref.read(trainCompanyProvider.notifier).setSelectedTrainNumber(selectedTrainNumber: ''),
                    child: const Text('clear'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: context.screenSize.width,
                height: context.screenSize.height * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: displayTrain(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayTrainCompany() {
    final list = <Widget>[];

    final selectedCompanyName = _ref.watch(trainCompanyProvider.select((value) => value.selectedCompanyName));

    //=====================//
    var trainCompanyList = _ref.watch(trainCompanyProvider.select((value) => value.trainCompanyList));

    final traincompanylistPref = _ref.watch(areaPrefectureProvider.select((value) => value.trainCompanyList));

    if (traincompanylistPref.isNotEmpty) {
      trainCompanyList = traincompanylistPref;
    }
    //=====================//

    trainCompanyList.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(element.companyName),
              GestureDetector(
                onTap: () => _ref
                    .read(trainCompanyProvider.notifier)
                    .setSelectedCompanyName(selectedCompanyName: element.companyName),
                child: (selectedCompanyName == element.companyName)
                    ? const Icon(Icons.check_box_outlined, size: 20, color: Colors.blueAccent)
                    : Icon(Icons.check_box_outline_blank_outlined, size: 20, color: Colors.white.withOpacity(0.4)),
              ),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list)),
    );
  }

  ///
  Widget displayTrain() {
    final list = <Widget>[];

    final selectedCompanyName = _ref.watch(trainCompanyProvider.select((value) => value.selectedCompanyName));

    final selectedTrainNumber = _ref.watch(trainCompanyProvider.select((value) => value.selectedTrainNumber));

    final companyTrainMap = _ref.watch(trainCompanyProvider.select((value) => value.companyTrainMap));

    var i = 0;
    companyTrainMap[selectedCompanyName]?.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$i : ${element.trainName}'),
              GestureDetector(
                onTap: () async {
                  await _ref
                      .read(trainCompanyProvider.notifier)
                      .setSelectedTrainNumber(selectedTrainNumber: element.trainNumber);

                  await _ref.read(trainStationProvider.notifier).getTrainStation(trainNumber: element.trainNumber);

                  await OritimerDialog(context: _context, widget: StationSelectAlert(train: element));
                },
                child: (selectedTrainNumber == element.trainNumber)
                    ? const Icon(Icons.check_box_outlined, size: 20, color: Colors.blueAccent)
                    : Icon(Icons.check_box_outline_blank_outlined, size: 20, color: Colors.white.withOpacity(0.4)),
              ),
            ],
          ),
        ),
      );

      i++;
    });

    return SingleChildScrollView(
      child: DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list)),
    );
  }
}
