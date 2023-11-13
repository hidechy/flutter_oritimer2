import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/area_prefecture.dart';
import '../../models/train_company.dart';
import '../../utility/utility.dart';
import 'area_prefecture_response_state.dart';

////////////////////////////////////////////////
final areaPrefectureProvider =
    StateNotifierProvider.autoDispose<AreaPrefectureNotifier, AreaPrefectureResponseState>((ref) {
  final client = ref.watch(httpClientProvider);

  final utility = Utility();

  return AreaPrefectureNotifier(const AreaPrefectureResponseState(), client, utility)..getAreaPrefecture();
});

class AreaPrefectureNotifier extends StateNotifier<AreaPrefectureResponseState> {
  AreaPrefectureNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getAreaPrefecture() async {
    await client.post(path: APIPath.getPrefecture).then((value) {
      final list = <AreaPrefecture>[];
      final map = <String, List<AreaPrefecture>>{};

      // ignore: avoid_dynamic_calls
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        // ignore: avoid_dynamic_calls
        final val = AreaPrefecture.fromJson(value['data'][i] as Map<String, dynamic>);
        list.add(val);

        map[val.area] = [];
      }

      // ignore: avoid_dynamic_calls
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        // ignore: avoid_dynamic_calls
        final val = AreaPrefecture.fromJson(value['data'][i] as Map<String, dynamic>);

        map[val.area]?.add(val);
      }

      state = state.copyWith(areaPrefectureList: list, areaPrefectureMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> getAreaPrefectureCompany({required String prefecture}) async {
    await client.post(
      path: APIPath.getPrefectureTrainCompany,
      body: {'prefecture': prefecture},
    ).then((value) {
      final list = <TrainCompany>[];

      // ignore: avoid_dynamic_calls
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        // ignore: avoid_dynamic_calls
        final val = TrainCompany.fromJson(value['data'][i] as Map<String, dynamic>);
        list.add(val);
      }

      state = state.copyWith(trainCompanyList: list);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
