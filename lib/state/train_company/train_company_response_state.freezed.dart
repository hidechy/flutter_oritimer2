// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'train_company_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainCompanyResponseState {
//
  List<TrainCompany> get trainCompanyList =>
      throw _privateConstructorUsedError; //
  Map<String, List<Train>> get companyTrainMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainCompanyResponseStateCopyWith<TrainCompanyResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainCompanyResponseStateCopyWith<$Res> {
  factory $TrainCompanyResponseStateCopyWith(TrainCompanyResponseState value,
          $Res Function(TrainCompanyResponseState) then) =
      _$TrainCompanyResponseStateCopyWithImpl<$Res, TrainCompanyResponseState>;
  @useResult
  $Res call(
      {List<TrainCompany> trainCompanyList,
      Map<String, List<Train>> companyTrainMap});
}

/// @nodoc
class _$TrainCompanyResponseStateCopyWithImpl<$Res,
        $Val extends TrainCompanyResponseState>
    implements $TrainCompanyResponseStateCopyWith<$Res> {
  _$TrainCompanyResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainCompanyList = null,
    Object? companyTrainMap = null,
  }) {
    return _then(_value.copyWith(
      trainCompanyList: null == trainCompanyList
          ? _value.trainCompanyList
          : trainCompanyList // ignore: cast_nullable_to_non_nullable
              as List<TrainCompany>,
      companyTrainMap: null == companyTrainMap
          ? _value.companyTrainMap
          : companyTrainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Train>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainCompanyResponseStateImplCopyWith<$Res>
    implements $TrainCompanyResponseStateCopyWith<$Res> {
  factory _$$TrainCompanyResponseStateImplCopyWith(
          _$TrainCompanyResponseStateImpl value,
          $Res Function(_$TrainCompanyResponseStateImpl) then) =
      __$$TrainCompanyResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TrainCompany> trainCompanyList,
      Map<String, List<Train>> companyTrainMap});
}

/// @nodoc
class __$$TrainCompanyResponseStateImplCopyWithImpl<$Res>
    extends _$TrainCompanyResponseStateCopyWithImpl<$Res,
        _$TrainCompanyResponseStateImpl>
    implements _$$TrainCompanyResponseStateImplCopyWith<$Res> {
  __$$TrainCompanyResponseStateImplCopyWithImpl(
      _$TrainCompanyResponseStateImpl _value,
      $Res Function(_$TrainCompanyResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainCompanyList = null,
    Object? companyTrainMap = null,
  }) {
    return _then(_$TrainCompanyResponseStateImpl(
      trainCompanyList: null == trainCompanyList
          ? _value._trainCompanyList
          : trainCompanyList // ignore: cast_nullable_to_non_nullable
              as List<TrainCompany>,
      companyTrainMap: null == companyTrainMap
          ? _value._companyTrainMap
          : companyTrainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Train>>,
    ));
  }
}

/// @nodoc

class _$TrainCompanyResponseStateImpl implements _TrainCompanyResponseState {
  const _$TrainCompanyResponseStateImpl(
      {final List<TrainCompany> trainCompanyList = const [],
      final Map<String, List<Train>> companyTrainMap = const {}})
      : _trainCompanyList = trainCompanyList,
        _companyTrainMap = companyTrainMap;

//
  final List<TrainCompany> _trainCompanyList;
//
  @override
  @JsonKey()
  List<TrainCompany> get trainCompanyList {
    if (_trainCompanyList is EqualUnmodifiableListView)
      return _trainCompanyList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trainCompanyList);
  }

//
  final Map<String, List<Train>> _companyTrainMap;
//
  @override
  @JsonKey()
  Map<String, List<Train>> get companyTrainMap {
    if (_companyTrainMap is EqualUnmodifiableMapView) return _companyTrainMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_companyTrainMap);
  }

  @override
  String toString() {
    return 'TrainCompanyResponseState(trainCompanyList: $trainCompanyList, companyTrainMap: $companyTrainMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainCompanyResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._trainCompanyList, _trainCompanyList) &&
            const DeepCollectionEquality()
                .equals(other._companyTrainMap, _companyTrainMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_trainCompanyList),
      const DeepCollectionEquality().hash(_companyTrainMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainCompanyResponseStateImplCopyWith<_$TrainCompanyResponseStateImpl>
      get copyWith => __$$TrainCompanyResponseStateImplCopyWithImpl<
          _$TrainCompanyResponseStateImpl>(this, _$identity);
}

abstract class _TrainCompanyResponseState implements TrainCompanyResponseState {
  const factory _TrainCompanyResponseState(
          {final List<TrainCompany> trainCompanyList,
          final Map<String, List<Train>> companyTrainMap}) =
      _$TrainCompanyResponseStateImpl;

  @override //
  List<TrainCompany> get trainCompanyList;
  @override //
  Map<String, List<Train>> get companyTrainMap;
  @override
  @JsonKey(ignore: true)
  _$$TrainCompanyResponseStateImplCopyWith<_$TrainCompanyResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
