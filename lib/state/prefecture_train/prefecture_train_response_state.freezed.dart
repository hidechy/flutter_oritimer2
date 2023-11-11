// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prefecture_train_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrefectureTrainResponseState {
  List<Prefecture> get prefectureList => throw _privateConstructorUsedError;
  List<PrefectureTrain> get prefectureTrainList =>
      throw _privateConstructorUsedError;
  Map<String, List<String>> get areaPrefectureMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrefectureTrainResponseStateCopyWith<PrefectureTrainResponseState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrefectureTrainResponseStateCopyWith<$Res> {
  factory $PrefectureTrainResponseStateCopyWith(
          PrefectureTrainResponseState value,
          $Res Function(PrefectureTrainResponseState) then) =
      _$PrefectureTrainResponseStateCopyWithImpl<$Res,
          PrefectureTrainResponseState>;
  @useResult
  $Res call(
      {List<Prefecture> prefectureList,
      List<PrefectureTrain> prefectureTrainList,
      Map<String, List<String>> areaPrefectureMap});
}

/// @nodoc
class _$PrefectureTrainResponseStateCopyWithImpl<$Res,
        $Val extends PrefectureTrainResponseState>
    implements $PrefectureTrainResponseStateCopyWith<$Res> {
  _$PrefectureTrainResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefectureList = null,
    Object? prefectureTrainList = null,
    Object? areaPrefectureMap = null,
  }) {
    return _then(_value.copyWith(
      prefectureList: null == prefectureList
          ? _value.prefectureList
          : prefectureList // ignore: cast_nullable_to_non_nullable
              as List<Prefecture>,
      prefectureTrainList: null == prefectureTrainList
          ? _value.prefectureTrainList
          : prefectureTrainList // ignore: cast_nullable_to_non_nullable
              as List<PrefectureTrain>,
      areaPrefectureMap: null == areaPrefectureMap
          ? _value.areaPrefectureMap
          : areaPrefectureMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrefectureTrainResponseStateImplCopyWith<$Res>
    implements $PrefectureTrainResponseStateCopyWith<$Res> {
  factory _$$PrefectureTrainResponseStateImplCopyWith(
          _$PrefectureTrainResponseStateImpl value,
          $Res Function(_$PrefectureTrainResponseStateImpl) then) =
      __$$PrefectureTrainResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Prefecture> prefectureList,
      List<PrefectureTrain> prefectureTrainList,
      Map<String, List<String>> areaPrefectureMap});
}

/// @nodoc
class __$$PrefectureTrainResponseStateImplCopyWithImpl<$Res>
    extends _$PrefectureTrainResponseStateCopyWithImpl<$Res,
        _$PrefectureTrainResponseStateImpl>
    implements _$$PrefectureTrainResponseStateImplCopyWith<$Res> {
  __$$PrefectureTrainResponseStateImplCopyWithImpl(
      _$PrefectureTrainResponseStateImpl _value,
      $Res Function(_$PrefectureTrainResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefectureList = null,
    Object? prefectureTrainList = null,
    Object? areaPrefectureMap = null,
  }) {
    return _then(_$PrefectureTrainResponseStateImpl(
      prefectureList: null == prefectureList
          ? _value._prefectureList
          : prefectureList // ignore: cast_nullable_to_non_nullable
              as List<Prefecture>,
      prefectureTrainList: null == prefectureTrainList
          ? _value._prefectureTrainList
          : prefectureTrainList // ignore: cast_nullable_to_non_nullable
              as List<PrefectureTrain>,
      areaPrefectureMap: null == areaPrefectureMap
          ? _value._areaPrefectureMap
          : areaPrefectureMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$PrefectureTrainResponseStateImpl
    implements _PrefectureTrainResponseState {
  const _$PrefectureTrainResponseStateImpl(
      {final List<Prefecture> prefectureList = const [],
      final List<PrefectureTrain> prefectureTrainList = const [],
      final Map<String, List<String>> areaPrefectureMap = const {}})
      : _prefectureList = prefectureList,
        _prefectureTrainList = prefectureTrainList,
        _areaPrefectureMap = areaPrefectureMap;

  final List<Prefecture> _prefectureList;
  @override
  @JsonKey()
  List<Prefecture> get prefectureList {
    if (_prefectureList is EqualUnmodifiableListView) return _prefectureList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prefectureList);
  }

  final List<PrefectureTrain> _prefectureTrainList;
  @override
  @JsonKey()
  List<PrefectureTrain> get prefectureTrainList {
    if (_prefectureTrainList is EqualUnmodifiableListView)
      return _prefectureTrainList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prefectureTrainList);
  }

  final Map<String, List<String>> _areaPrefectureMap;
  @override
  @JsonKey()
  Map<String, List<String>> get areaPrefectureMap {
    if (_areaPrefectureMap is EqualUnmodifiableMapView)
      return _areaPrefectureMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_areaPrefectureMap);
  }

  @override
  String toString() {
    return 'PrefectureTrainResponseState(prefectureList: $prefectureList, prefectureTrainList: $prefectureTrainList, areaPrefectureMap: $areaPrefectureMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrefectureTrainResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._prefectureList, _prefectureList) &&
            const DeepCollectionEquality()
                .equals(other._prefectureTrainList, _prefectureTrainList) &&
            const DeepCollectionEquality()
                .equals(other._areaPrefectureMap, _areaPrefectureMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_prefectureList),
      const DeepCollectionEquality().hash(_prefectureTrainList),
      const DeepCollectionEquality().hash(_areaPrefectureMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrefectureTrainResponseStateImplCopyWith<
          _$PrefectureTrainResponseStateImpl>
      get copyWith => __$$PrefectureTrainResponseStateImplCopyWithImpl<
          _$PrefectureTrainResponseStateImpl>(this, _$identity);
}

abstract class _PrefectureTrainResponseState
    implements PrefectureTrainResponseState {
  const factory _PrefectureTrainResponseState(
          {final List<Prefecture> prefectureList,
          final List<PrefectureTrain> prefectureTrainList,
          final Map<String, List<String>> areaPrefectureMap}) =
      _$PrefectureTrainResponseStateImpl;

  @override
  List<Prefecture> get prefectureList;
  @override
  List<PrefectureTrain> get prefectureTrainList;
  @override
  Map<String, List<String>> get areaPrefectureMap;
  @override
  @JsonKey(ignore: true)
  _$$PrefectureTrainResponseStateImplCopyWith<
          _$PrefectureTrainResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
