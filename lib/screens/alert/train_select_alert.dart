// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/train_company.dart';
import '../../state/train_company/train_company_notifier.dart';

class TrainSelectAlert extends ConsumerWidget {
  TrainSelectAlert({super.key});

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    onTap: () {},
                    child: Text('clear'),
                  ),
                ],
              ),
              Container(
                height: context.screenSize.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.35)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: displayTrainCompany(),
              ),
              const SizedBox(height: 20),
              const Text('Train'),
              Container(
                height: context.screenSize.height * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(16),
                ),
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

    _ref.watch(trainCompanyProvider.select((value) => value.companyTrainMap)).forEach((key, value) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key),
              Icon(Icons.check_box_outline_blank_outlined, size: 20, color: Colors.white.withOpacity(0.4)),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list)),
    );
  }
}
