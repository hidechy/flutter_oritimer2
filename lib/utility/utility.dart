import 'dart:math';

import 'package:flutter/material.dart';

class Utility {
  ///
  void showError(String msg) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  ///
  String calcDistance({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
  }) {
    final distanceKm = 6371 *
        acos(
          cos(originLat / 180 * pi) * cos((destLng - originLng) / 180 * pi) * cos(destLat / 180 * pi) +
              sin(originLat / 180 * pi) * sin(destLat / 180 * pi),
        );

    final exDistance = distanceKm.toString().split('.');

    final seisuu = exDistance[0];
    final shousuu = exDistance[1].substring(0, 2);

    return '$seisuu.$shousuu';
  }
}

class NavigationService {
  const NavigationService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
