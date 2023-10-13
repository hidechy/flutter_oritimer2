// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/train_station.dart';
import '../../utility/utility.dart';
import 'train_station_response_state.dart';

////////////////////////////////////////////////
final trainStationProvider =
    StateNotifierProvider.autoDispose.family<TrainStationNotifier, TrainStationResponseState, String>((ref, param) {
  final client = ref.watch(httpClientProvider);

  final utility = Utility();

  return TrainStationNotifier(const TrainStationResponseState(), client, utility)..getTrainStation(param: param);
});

class TrainStationNotifier extends StateNotifier<TrainStationResponseState> {
  TrainStationNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getTrainStation({required String param}) async {
    await client.post(path: APIPath.getTrainStation, body: {'train_number': param}).then((value) {
      final list = <TrainStation>[];
      final map = <String, TrainStation>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = TrainStation.fromJson(value['data'][i] as Map<String, dynamic>);

        list.add(val);

        map[val.stationName] = val;
      }

      state = state.copyWith(stationList: list, stationNameMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
