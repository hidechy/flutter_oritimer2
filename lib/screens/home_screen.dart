// ignore_for_file: must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../extensions/extensions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

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
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: context.screenSize.width,
              height: 70,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircularCountDownTimer(
                    duration: 20,
                    width: context.screenSize.width / 10,
                    height: context.screenSize.height / 10,
                    ringColor: Colors.blueAccent,
                    fillColor: Colors.white,
                    onComplete: _goHomeScreen,
                    textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateTime.now().yyyymmdd),
                      Text(currentTime),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  void _goHomeScreen() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
