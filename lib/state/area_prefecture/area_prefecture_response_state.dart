import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/area_prefecture.dart';

part 'area_prefecture_response_state.freezed.dart';

@freezed
class AreaPrefectureResponseState with _$AreaPrefectureResponseState {
  const factory AreaPrefectureResponseState({
    @Default([]) List<AreaPrefecture> areaPrefectureList,
    @Default({}) Map<String, List<AreaPrefecture>> areaPrefectureMap,
  }) = _AreaPrefectureResponseState;
}
