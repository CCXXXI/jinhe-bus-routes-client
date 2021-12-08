// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'query_logic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StationTearOff {
  const _$StationTearOff();

  _Station call(String zh, String en, String id) {
    return _Station(
      zh,
      en,
      id,
    );
  }
}

/// @nodoc
const $Station = _$StationTearOff();

/// @nodoc
mixin _$Station {
  String get zh => throw _privateConstructorUsedError;

  String get en => throw _privateConstructorUsedError;

  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StationCopyWith<Station> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationCopyWith<$Res> {
  factory $StationCopyWith(Station value, $Res Function(Station) then) =
      _$StationCopyWithImpl<$Res>;

  $Res call({String zh, String en, String id});
}

/// @nodoc
class _$StationCopyWithImpl<$Res> implements $StationCopyWith<$Res> {
  _$StationCopyWithImpl(this._value, this._then);

  final Station _value;

  // ignore: unused_field
  final $Res Function(Station) _then;

  @override
  $Res call({
    Object? zh = freezed,
    Object? en = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      zh: zh == freezed
          ? _value.zh
          : zh // ignore: cast_nullable_to_non_nullable
              as String,
      en: en == freezed
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$StationCopyWith<$Res> implements $StationCopyWith<$Res> {
  factory _$StationCopyWith(_Station value, $Res Function(_Station) then) =
      __$StationCopyWithImpl<$Res>;

  @override
  $Res call({String zh, String en, String id});
}

/// @nodoc
class __$StationCopyWithImpl<$Res> extends _$StationCopyWithImpl<$Res>
    implements _$StationCopyWith<$Res> {
  __$StationCopyWithImpl(_Station _value, $Res Function(_Station) _then)
      : super(_value, (v) => _then(v as _Station));

  @override
  _Station get _value => super._value as _Station;

  @override
  $Res call({
    Object? zh = freezed,
    Object? en = freezed,
    Object? id = freezed,
  }) {
    return _then(_Station(
      zh == freezed
          ? _value.zh
          : zh // ignore: cast_nullable_to_non_nullable
              as String,
      en == freezed
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Station extends _Station {
  _$_Station(this.zh, this.en, this.id) : super._();

  @override
  final String zh;
  @override
  final String en;
  @override
  final String id;

  @override
  String toString() {
    return 'Station(zh: $zh, en: $en, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Station &&
            const DeepCollectionEquality().equals(other.zh, zh) &&
            const DeepCollectionEquality().equals(other.en, en) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(zh),
      const DeepCollectionEquality().hash(en),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$StationCopyWith<_Station> get copyWith =>
      __$StationCopyWithImpl<_Station>(this, _$identity);
}

abstract class _Station extends Station {
  factory _Station(String zh, String en, String id) = _$_Station;

  _Station._() : super._();

  @override
  String get zh;

  @override
  String get en;

  @override
  String get id;

  @override
  @JsonKey(ignore: true)
  _$StationCopyWith<_Station> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$StationGroupTearOff {
  const _$StationGroupTearOff();

  _StationGroup call(String zh, String en, SplayTreeSet<String> ids) {
    return _StationGroup(
      zh,
      en,
      ids,
    );
  }
}

/// @nodoc
const $StationGroup = _$StationGroupTearOff();

/// @nodoc
mixin _$StationGroup {
  String get zh => throw _privateConstructorUsedError;

  String get en => throw _privateConstructorUsedError;

  SplayTreeSet<String> get ids => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StationGroupCopyWith<StationGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationGroupCopyWith<$Res> {
  factory $StationGroupCopyWith(
          StationGroup value, $Res Function(StationGroup) then) =
      _$StationGroupCopyWithImpl<$Res>;

  $Res call({String zh, String en, SplayTreeSet<String> ids});
}

/// @nodoc
class _$StationGroupCopyWithImpl<$Res> implements $StationGroupCopyWith<$Res> {
  _$StationGroupCopyWithImpl(this._value, this._then);

  final StationGroup _value;

  // ignore: unused_field
  final $Res Function(StationGroup) _then;

  @override
  $Res call({
    Object? zh = freezed,
    Object? en = freezed,
    Object? ids = freezed,
  }) {
    return _then(_value.copyWith(
      zh: zh == freezed
          ? _value.zh
          : zh // ignore: cast_nullable_to_non_nullable
              as String,
      en: en == freezed
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      ids: ids == freezed
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as SplayTreeSet<String>,
    ));
  }
}

/// @nodoc
abstract class _$StationGroupCopyWith<$Res>
    implements $StationGroupCopyWith<$Res> {
  factory _$StationGroupCopyWith(
          _StationGroup value, $Res Function(_StationGroup) then) =
      __$StationGroupCopyWithImpl<$Res>;

  @override
  $Res call({String zh, String en, SplayTreeSet<String> ids});
}

/// @nodoc
class __$StationGroupCopyWithImpl<$Res> extends _$StationGroupCopyWithImpl<$Res>
    implements _$StationGroupCopyWith<$Res> {
  __$StationGroupCopyWithImpl(
      _StationGroup _value, $Res Function(_StationGroup) _then)
      : super(_value, (v) => _then(v as _StationGroup));

  @override
  _StationGroup get _value => super._value as _StationGroup;

  @override
  $Res call({
    Object? zh = freezed,
    Object? en = freezed,
    Object? ids = freezed,
  }) {
    return _then(_StationGroup(
      zh == freezed
          ? _value.zh
          : zh // ignore: cast_nullable_to_non_nullable
              as String,
      en == freezed
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      ids == freezed
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as SplayTreeSet<String>,
    ));
  }
}

/// @nodoc

class _$_StationGroup extends _StationGroup {
  _$_StationGroup(this.zh, this.en, this.ids) : super._();

  @override
  final String zh;
  @override
  final String en;
  @override
  final SplayTreeSet<String> ids;

  @override
  String toString() {
    return 'StationGroup(zh: $zh, en: $en, ids: $ids)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StationGroup &&
            const DeepCollectionEquality().equals(other.zh, zh) &&
            const DeepCollectionEquality().equals(other.en, en) &&
            const DeepCollectionEquality().equals(other.ids, ids));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(zh),
      const DeepCollectionEquality().hash(en),
      const DeepCollectionEquality().hash(ids));

  @JsonKey(ignore: true)
  @override
  _$StationGroupCopyWith<_StationGroup> get copyWith =>
      __$StationGroupCopyWithImpl<_StationGroup>(this, _$identity);
}

abstract class _StationGroup extends StationGroup {
  factory _StationGroup(String zh, String en, SplayTreeSet<String> ids) =
      _$_StationGroup;

  _StationGroup._() : super._();

  @override
  String get zh;

  @override
  String get en;

  @override
  SplayTreeSet<String> get ids;

  @override
  @JsonKey(ignore: true)
  _$StationGroupCopyWith<_StationGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$RouteTearOff {
  const _$RouteTearOff();

  _Route call(String name, bool? up) {
    return _Route(
      name,
      up,
    );
  }
}

/// @nodoc
const $Route = _$RouteTearOff();

/// @nodoc
mixin _$Route {
  String get name => throw _privateConstructorUsedError;

  bool? get up => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RouteCopyWith<Route> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteCopyWith<$Res> {
  factory $RouteCopyWith(Route value, $Res Function(Route) then) =
      _$RouteCopyWithImpl<$Res>;

  $Res call({String name, bool? up});
}

/// @nodoc
class _$RouteCopyWithImpl<$Res> implements $RouteCopyWith<$Res> {
  _$RouteCopyWithImpl(this._value, this._then);

  final Route _value;

  // ignore: unused_field
  final $Res Function(Route) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? up = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      up: up == freezed
          ? _value.up
          : up // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$RouteCopyWith<$Res> implements $RouteCopyWith<$Res> {
  factory _$RouteCopyWith(_Route value, $Res Function(_Route) then) =
      __$RouteCopyWithImpl<$Res>;

  @override
  $Res call({String name, bool? up});
}

/// @nodoc
class __$RouteCopyWithImpl<$Res> extends _$RouteCopyWithImpl<$Res>
    implements _$RouteCopyWith<$Res> {
  __$RouteCopyWithImpl(_Route _value, $Res Function(_Route) _then)
      : super(_value, (v) => _then(v as _Route));

  @override
  _Route get _value => super._value as _Route;

  @override
  $Res call({
    Object? name = freezed,
    Object? up = freezed,
  }) {
    return _then(_Route(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      up == freezed
          ? _value.up
          : up // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_Route extends _Route {
  _$_Route(this.name, this.up) : super._();

  @override
  final String name;
  @override
  final bool? up;

  @override
  String toString() {
    return 'Route(name: $name, up: $up)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Route &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.up, up));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(up));

  @JsonKey(ignore: true)
  @override
  _$RouteCopyWith<_Route> get copyWith =>
      __$RouteCopyWithImpl<_Route>(this, _$identity);
}

abstract class _Route extends Route {
  factory _Route(String name, bool? up) = _$_Route;

  _Route._() : super._();

  @override
  String get name;

  @override
  bool? get up;

  @override
  @JsonKey(ignore: true)
  _$RouteCopyWith<_Route> get copyWith => throw _privateConstructorUsedError;
}
