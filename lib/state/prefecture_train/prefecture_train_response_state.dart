import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/prefecture.dart';
import '../../models/prefecture_train.dart';

part 'prefecture_train_response_state.freezed.dart';

@freezed
class PrefectureTrainResponseState with _$PrefectureTrainResponseState {
  const factory PrefectureTrainResponseState({
    @Default([]) List<Prefecture> prefectureList,
    @Default([]) List<PrefectureTrain> prefectureTrainList,
    @Default({}) Map<String, List<String>> areaPrefectureMap,
  }) = _PrefectureTrainResponseState;
}
