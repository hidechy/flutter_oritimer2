import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'lat_lng_request_state.dart';
import 'lat_lng_response_state.dart';

////////////////////////////////////////////////
final latLngProvider = StateNotifierProvider.autoDispose<LatLngNotifier, LatLngResponseState>((ref) {
  return LatLngNotifier(const LatLngResponseState());
});

class LatLngNotifier extends StateNotifier<LatLngResponseState> {
  LatLngNotifier(super.state);

  ///
  Future<void> setLatLng({required LatLngRequestState param}) async =>
      state = state.copyWith(lat: param.lat, lng: param.lng);
}

////////////////////////////////////////////////
