import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_state.dart';

////////////////////////////////////////////////
final appProvider = StateNotifierProvider.autoDispose<AppNotifier, AppState>((ref) {
  return AppNotifier(const AppState());
});

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier(super.state);

  ///
  Future<void> setErrorMsg({required String msg}) async => state = state.copyWith(errorMsg: msg);

  ///
  Future<void> setDistance({required String distance}) async => state = state.copyWith(distance: distance);

  ///
  Future<void> setAreaAndPrefecture({required String area, required String prefecture}) async =>
      state = state.copyWith(selectArea: area, selectPrefecture: prefecture);
}

////////////////////////////////////////////////
