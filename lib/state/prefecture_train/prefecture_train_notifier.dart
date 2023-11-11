import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/prefecture.dart';
import '../../utility/utility.dart';
import 'prefecture_train_response_state.dart';

////////////////////////////////////////////////
final prefectureTrainProvider =
    StateNotifierProvider.autoDispose<PrefectureTrainNotifier, PrefectureTrainResponseState>((ref) {
  final client = ref.watch(httpClientProvider);

  final utility = Utility();

  return PrefectureTrainNotifier(const PrefectureTrainResponseState(), client, utility)..getPrefecture();
});

class PrefectureTrainNotifier extends StateNotifier<PrefectureTrainResponseState> {
  PrefectureTrainNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getPrefecture() async {
    await client.post(path: APIPath.getPrefecture).then((value) {
      final list = <Prefecture>[];

      final map = <String, List<String>>{};

      // ignore: avoid_dynamic_calls
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        // ignore: avoid_dynamic_calls
        final val = Prefecture.fromJson(value['data'][i] as Map<String, dynamic>);
        list.add(val);

        map[val.area] = [];
      }

      // ignore: avoid_dynamic_calls
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        // ignore: avoid_dynamic_calls
        final val = Prefecture.fromJson(value['data'][i] as Map<String, dynamic>);

        map[val.area]?.add(val.prefecture);
      }

      state = state.copyWith(prefectureList: list, areaPrefectureMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
