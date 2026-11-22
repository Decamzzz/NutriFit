// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weight_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeightLog {

 String? get id;@JsonKey(name: 'user_id') String? get userId; String get date;@JsonKey(name: 'weight_kg') double get weightKg;
/// Create a copy of WeightLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeightLogCopyWith<WeightLog> get copyWith => _$WeightLogCopyWithImpl<WeightLog>(this as WeightLog, _$identity);

  /// Serializes this WeightLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WeightLog;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightLog&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WeightLog;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.date,_this.weightKg);
}

@override
String toString() {
  final _this = this as WeightLog;
  return 'WeightLog(id: ${_this.id}, userId: ${_this.userId}, date: ${_this.date}, weightKg: ${_this.weightKg})';
}


}

/// @nodoc
abstract mixin class $WeightLogCopyWith<$Res>  {
  factory $WeightLogCopyWith(WeightLog value, $Res Function(WeightLog) _then) = _$WeightLogCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'user_id') String? userId, String date,@JsonKey(name: 'weight_kg') double weightKg
});




}
/// @nodoc
class _$WeightLogCopyWithImpl<$Res>
    implements $WeightLogCopyWith<$Res> {
  _$WeightLogCopyWithImpl(this._self, this._then);

  final WeightLog _self;
  final $Res Function(WeightLog) _then;

/// Create a copy of WeightLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? date = null,Object? weightKg = null,}) {
  return _then(WeightLog(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WeightLog].
extension WeightLogPatterns on WeightLog {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeightLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeightLog() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeightLog value)  $default,){
final _that = this;
switch (_that) {
case _WeightLog():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeightLog value)?  $default,){
final _that = this;
switch (_that) {
case _WeightLog() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_id')  String? userId,  String date, @JsonKey(name: 'weight_kg')  double weightKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeightLog() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.weightKg);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_id')  String? userId,  String date, @JsonKey(name: 'weight_kg')  double weightKg)  $default,) {final _that = this;
switch (_that) {
case _WeightLog():
return $default(_that.id,_that.userId,_that.date,_that.weightKg);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'user_id')  String? userId,  String date, @JsonKey(name: 'weight_kg')  double weightKg)?  $default,) {final _that = this;
switch (_that) {
case _WeightLog() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.weightKg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeightLog implements WeightLog {
  const _WeightLog({this.id, @JsonKey(name: 'user_id') this.userId, required this.date, @JsonKey(name: 'weight_kg') required this.weightKg});
  factory _WeightLog.fromJson(Map<String, dynamic> json) => _$WeightLogFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'user_id') final  String? userId;
@override final  String date;
@override@JsonKey(name: 'weight_kg') final  double weightKg;

/// Create a copy of WeightLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeightLogCopyWith<_WeightLog> get copyWith => __$WeightLogCopyWithImpl<_WeightLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeightLogToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeightLog&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,date,weightKg);
}

@override
String toString() {
    return 'WeightLog(id: $id, userId: $userId, date: $date, weightKg: $weightKg)';
}


}

/// @nodoc
abstract mixin class _$WeightLogCopyWith<$Res> implements $WeightLogCopyWith<$Res> {
  factory _$WeightLogCopyWith(_WeightLog value, $Res Function(_WeightLog) _then) = __$WeightLogCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'user_id') String? userId, String date,@JsonKey(name: 'weight_kg') double weightKg
});




}
/// @nodoc
class __$WeightLogCopyWithImpl<$Res>
    implements _$WeightLogCopyWith<$Res> {
  __$WeightLogCopyWithImpl(this._self, this._then);

  final _WeightLog _self;
  final $Res Function(_WeightLog) _then;

/// Create a copy of WeightLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? date = null,Object? weightKg = null,}) {
  return _then(_WeightLog(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
