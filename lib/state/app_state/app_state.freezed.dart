// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  ///
  String get errorMsg => throw _privateConstructorUsedError;

  ///
  String get distance => throw _privateConstructorUsedError;

  ///
  String get selectArea => throw _privateConstructorUsedError;
  String get selectPrefecture => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {String errorMsg,
      String distance,
      String selectArea,
      String selectPrefecture});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMsg = null,
    Object? distance = null,
    Object? selectArea = null,
    Object? selectPrefecture = null,
  }) {
    return _then(_value.copyWith(
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      selectArea: null == selectArea
          ? _value.selectArea
          : selectArea // ignore: cast_nullable_to_non_nullable
              as String,
      selectPrefecture: null == selectPrefecture
          ? _value.selectPrefecture
          : selectPrefecture // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String errorMsg,
      String distance,
      String selectArea,
      String selectPrefecture});
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMsg = null,
    Object? distance = null,
    Object? selectArea = null,
    Object? selectPrefecture = null,
  }) {
    return _then(_$AppStateImpl(
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      selectArea: null == selectArea
          ? _value.selectArea
          : selectArea // ignore: cast_nullable_to_non_nullable
              as String,
      selectPrefecture: null == selectPrefecture
          ? _value.selectPrefecture
          : selectPrefecture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  const _$AppStateImpl(
      {this.errorMsg = '',
      this.distance = '',
      this.selectArea = '',
      this.selectPrefecture = ''});

  ///
  @override
  @JsonKey()
  final String errorMsg;

  ///
  @override
  @JsonKey()
  final String distance;

  ///
  @override
  @JsonKey()
  final String selectArea;
  @override
  @JsonKey()
  final String selectPrefecture;

  @override
  String toString() {
    return 'AppState(errorMsg: $errorMsg, distance: $distance, selectArea: $selectArea, selectPrefecture: $selectPrefecture)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.selectArea, selectArea) ||
                other.selectArea == selectArea) &&
            (identical(other.selectPrefecture, selectPrefecture) ||
                other.selectPrefecture == selectPrefecture));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, errorMsg, distance, selectArea, selectPrefecture);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final String errorMsg,
      final String distance,
      final String selectArea,
      final String selectPrefecture}) = _$AppStateImpl;

  @override

  ///
  String get errorMsg;
  @override

  ///
  String get distance;
  @override

  ///
  String get selectArea;
  @override
  String get selectPrefecture;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
