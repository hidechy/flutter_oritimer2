// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/train_company.dart';
import '../../utility/utility.dart';
import 'train_company_response_state.dart';

////////////////////////////////////////////////
final trainCompanyProvider = StateNotifierProvider.autoDispose<TrainCompanyNotifier, TrainCompanyResponseState>((ref) {
  final client = ref.watch(httpClientProvider);

  final utility = Utility();

  return TrainCompanyNotifier(const TrainCompanyResponseState(), client, utility)..getTrainCompany();
});

class TrainCompanyNotifier extends StateNotifier<TrainCompanyResponseState> {
  TrainCompanyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getTrainCompany() async {
    await client.post(path: APIPath.getTrainCompany).then((value) {
      final list = <TrainCompany>[];
      final map = <String, List<Train>>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = TrainCompany.fromJson(value['data'][i] as Map<String, dynamic>);

        list.add(val);

        map[val.companyName] = [...val.train];
      }

      state = state.copyWith(trainCompanyList: list, companyTrainMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
