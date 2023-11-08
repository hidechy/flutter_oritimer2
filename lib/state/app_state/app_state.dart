import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    ///
    @Default('') String errorMsg,

    ///
    @Default('') String distance,
  }) = _AppState;
}
