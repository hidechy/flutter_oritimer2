// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lat_lng_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LatLngResponseState {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  double get stationLat => throw _privateConstructorUsedError;
  double get stationLng => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LatLngResponseStateCopyWith<LatLngResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngResponseStateCopyWith<$Res> {
  factory $LatLngResponseStateCopyWith(
          LatLngResponseState value, $Res Function(LatLngResponseState) then) =
      _$LatLngResponseStateCopyWithImpl<$Res, LatLngResponseState>;
  @useResult
  $Res call({double lat, double lng, double stationLat, double stationLng});
}

/// @nodoc
class _$LatLngResponseStateCopyWithImpl<$Res, $Val extends LatLngResponseState>
    implements $LatLngResponseStateCopyWith<$Res> {
  _$LatLngResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? stationLat = null,
    Object? stationLng = null,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      stationLat: null == stationLat
          ? _value.stationLat
          : stationLat // ignore: cast_nullable_to_non_nullable
              as double,
      stationLng: null == stationLng
          ? _value.stationLng
          : stationLng // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LatLngResponseStateImplCopyWith<$Res>
    implements $LatLngResponseStateCopyWith<$Res> {
  factory _$$LatLngResponseStateImplCopyWith(_$LatLngResponseStateImpl value,
          $Res Function(_$LatLngResponseStateImpl) then) =
      __$$LatLngResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng, double stationLat, double stationLng});
}

/// @nodoc
class __$$LatLngResponseStateImplCopyWithImpl<$Res>
    extends _$LatLngResponseStateCopyWithImpl<$Res, _$LatLngResponseStateImpl>
    implements _$$LatLngResponseStateImplCopyWith<$Res> {
  __$$LatLngResponseStateImplCopyWithImpl(_$LatLngResponseStateImpl _value,
      $Res Function(_$LatLngResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? stationLat = null,
    Object? stationLng = null,
  }) {
    return _then(_$LatLngResponseStateImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      stationLat: null == stationLat
          ? _value.stationLat
          : stationLat // ignore: cast_nullable_to_non_nullable
              as double,
      stationLng: null == stationLng
          ? _value.stationLng
          : stationLng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$LatLngResponseStateImpl implements _LatLngResponseState {
  const _$LatLngResponseStateImpl(
      {this.lat = 0.0,
      this.lng = 0.0,
      this.stationLat = 0.0,
      this.stationLng = 0.0});

  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double lng;
  @override
  @JsonKey()
  final double stationLat;
  @override
  @JsonKey()
  final double stationLng;

  @override
  String toString() {
    return 'LatLngResponseState(lat: $lat, lng: $lng, stationLat: $stationLat, stationLng: $stationLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngResponseStateImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.stationLat, stationLat) ||
                other.stationLat == stationLat) &&
            (identical(other.stationLng, stationLng) ||
                other.stationLng == stationLng));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, lat, lng, stationLat, stationLng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngResponseStateImplCopyWith<_$LatLngResponseStateImpl> get copyWith =>
      __$$LatLngResponseStateImplCopyWithImpl<_$LatLngResponseStateImpl>(
          this, _$identity);
}

abstract class _LatLngResponseState implements LatLngResponseState {
  const factory _LatLngResponseState(
      {final double lat,
      final double lng,
      final double stationLat,
      final double stationLng}) = _$LatLngResponseStateImpl;

  @override
  double get lat;
  @override
  double get lng;
  @override
  double get stationLat;
  @override
  double get stationLng;
  @override
  @JsonKey(ignore: true)
  _$$LatLngResponseStateImplCopyWith<_$LatLngResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
