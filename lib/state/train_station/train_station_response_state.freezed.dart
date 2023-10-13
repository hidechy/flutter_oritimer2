// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'train_station_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainStationResponseState {
//
  List<TrainStation> get stationList => throw _privateConstructorUsedError; //
  Map<String, TrainStation> get stationNameMap =>
      throw _privateConstructorUsedError; //
  TrainStation? get selectedTrainStation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainStationResponseStateCopyWith<TrainStationResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainStationResponseStateCopyWith<$Res> {
  factory $TrainStationResponseStateCopyWith(TrainStationResponseState value,
          $Res Function(TrainStationResponseState) then) =
      _$TrainStationResponseStateCopyWithImpl<$Res, TrainStationResponseState>;
  @useResult
  $Res call(
      {List<TrainStation> stationList,
      Map<String, TrainStation> stationNameMap,
      TrainStation? selectedTrainStation});
}

/// @nodoc
class _$TrainStationResponseStateCopyWithImpl<$Res,
        $Val extends TrainStationResponseState>
    implements $TrainStationResponseStateCopyWith<$Res> {
  _$TrainStationResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationList = null,
    Object? stationNameMap = null,
    Object? selectedTrainStation = freezed,
  }) {
    return _then(_value.copyWith(
      stationList: null == stationList
          ? _value.stationList
          : stationList // ignore: cast_nullable_to_non_nullable
              as List<TrainStation>,
      stationNameMap: null == stationNameMap
          ? _value.stationNameMap
          : stationNameMap // ignore: cast_nullable_to_non_nullable
              as Map<String, TrainStation>,
      selectedTrainStation: freezed == selectedTrainStation
          ? _value.selectedTrainStation
          : selectedTrainStation // ignore: cast_nullable_to_non_nullable
              as TrainStation?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainStationResponseStateImplCopyWith<$Res>
    implements $TrainStationResponseStateCopyWith<$Res> {
  factory _$$TrainStationResponseStateImplCopyWith(
          _$TrainStationResponseStateImpl value,
          $Res Function(_$TrainStationResponseStateImpl) then) =
      __$$TrainStationResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TrainStation> stationList,
      Map<String, TrainStation> stationNameMap,
      TrainStation? selectedTrainStation});
}

/// @nodoc
class __$$TrainStationResponseStateImplCopyWithImpl<$Res>
    extends _$TrainStationResponseStateCopyWithImpl<$Res,
        _$TrainStationResponseStateImpl>
    implements _$$TrainStationResponseStateImplCopyWith<$Res> {
  __$$TrainStationResponseStateImplCopyWithImpl(
      _$TrainStationResponseStateImpl _value,
      $Res Function(_$TrainStationResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationList = null,
    Object? stationNameMap = null,
    Object? selectedTrainStation = freezed,
  }) {
    return _then(_$TrainStationResponseStateImpl(
      stationList: null == stationList
          ? _value._stationList
          : stationList // ignore: cast_nullable_to_non_nullable
              as List<TrainStation>,
      stationNameMap: null == stationNameMap
          ? _value._stationNameMap
          : stationNameMap // ignore: cast_nullable_to_non_nullable
              as Map<String, TrainStation>,
      selectedTrainStation: freezed == selectedTrainStation
          ? _value.selectedTrainStation
          : selectedTrainStation // ignore: cast_nullable_to_non_nullable
              as TrainStation?,
    ));
  }
}

/// @nodoc

class _$TrainStationResponseStateImpl implements _TrainStationResponseState {
  const _$TrainStationResponseStateImpl(
      {final List<TrainStation> stationList = const [],
      final Map<String, TrainStation> stationNameMap = const {},
      this.selectedTrainStation})
      : _stationList = stationList,
        _stationNameMap = stationNameMap;

//
  final List<TrainStation> _stationList;
//
  @override
  @JsonKey()
  List<TrainStation> get stationList {
    if (_stationList is EqualUnmodifiableListView) return _stationList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stationList);
  }

//
  final Map<String, TrainStation> _stationNameMap;
//
  @override
  @JsonKey()
  Map<String, TrainStation> get stationNameMap {
    if (_stationNameMap is EqualUnmodifiableMapView) return _stationNameMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stationNameMap);
  }

//
  @override
  final TrainStation? selectedTrainStation;

  @override
  String toString() {
    return 'TrainStationResponseState(stationList: $stationList, stationNameMap: $stationNameMap, selectedTrainStation: $selectedTrainStation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainStationResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._stationList, _stationList) &&
            const DeepCollectionEquality()
                .equals(other._stationNameMap, _stationNameMap) &&
            (identical(other.selectedTrainStation, selectedTrainStation) ||
                other.selectedTrainStation == selectedTrainStation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_stationList),
      const DeepCollectionEquality().hash(_stationNameMap),
      selectedTrainStation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainStationResponseStateImplCopyWith<_$TrainStationResponseStateImpl>
      get copyWith => __$$TrainStationResponseStateImplCopyWithImpl<
          _$TrainStationResponseStateImpl>(this, _$identity);
}

abstract class _TrainStationResponseState implements TrainStationResponseState {
  const factory _TrainStationResponseState(
          {final List<TrainStation> stationList,
          final Map<String, TrainStation> stationNameMap,
          final TrainStation? selectedTrainStation}) =
      _$TrainStationResponseStateImpl;

  @override //
  List<TrainStation> get stationList;
  @override //
  Map<String, TrainStation> get stationNameMap;
  @override //
  TrainStation? get selectedTrainStation;
  @override
  @JsonKey(ignore: true)
  _$$TrainStationResponseStateImplCopyWith<_$TrainStationResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
