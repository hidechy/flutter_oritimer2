// ignore_for_file: must_be_immutable, use_named_constants

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../extensions/extensions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Timer timer = Timer(const Duration(), () {});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 5), flash);
    });

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
                  onPressed: () {
                    timer.cancel();

                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(DateTime.now().yyyymmdd),
            Text(currentTime),
          ],
        ),
      ),
    );
  }

  ///
  void flash(Timer timer) => screenReload();

  ///
  void screenReload() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
