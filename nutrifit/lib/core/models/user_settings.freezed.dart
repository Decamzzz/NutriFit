// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettings {

 String get id; String? get email; String? get name; String get goal;@JsonKey(name: 'activity_level') String get activityLevel;@JsonKey(name: 'calorie_target') int get calorieTarget;@JsonKey(name: 'height_cm') double? get heightCm;@JsonKey(name: 'goal_weight_kg') double? get goalWeightKg;
/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsCopyWith<UserSettings> get copyWith => _$UserSettingsCopyWithImpl<UserSettings>(this as UserSettings, _$identity);

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettings&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.activityLevel, _this.activityLevel) || other.activityLevel == _this.activityLevel)&&(identical(other.calorieTarget, _this.calorieTarget) || other.calorieTarget == _this.calorieTarget)&&(identical(other.heightCm, _this.heightCm) || other.heightCm == _this.heightCm)&&(identical(other.goalWeightKg, _this.goalWeightKg) || other.goalWeightKg == _this.goalWeightKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserSettings;
  return Object.hash(runtimeType,_this.id,_this.email,_this.name,_this.goal,_this.activityLevel,_this.calorieTarget,_this.heightCm,_this.goalWeightKg);
}

@override
String toString() {
  final _this = this as UserSettings;
  return 'UserSettings(id: ${_this.id}, email: ${_this.email}, name: ${_this.name}, goal: ${_this.goal}, activityLevel: ${_this.activityLevel}, calorieTarget: ${_this.calorieTarget}, heightCm: ${_this.heightCm}, goalWeightKg: ${_this.goalWeightKg})';
}


}

/// @nodoc
abstract mixin class $UserSettingsCopyWith<$Res>  {
  factory $UserSettingsCopyWith(UserSettings value, $Res Function(UserSettings) _then) = _$UserSettingsCopyWithImpl;
@useResult
$Res call({
 String id, String? email, String? name, String goal,@JsonKey(name: 'activity_level') String activityLevel,@JsonKey(name: 'calorie_target') int calorieTarget,@JsonKey(name: 'height_cm') double? heightCm,@JsonKey(name: 'goal_weight_kg') double? goalWeightKg
});




}
/// @nodoc
class _$UserSettingsCopyWithImpl<$Res>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._self, this._then);

  final UserSettings _self;
  final $Res Function(UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,Object? name = freezed,Object? goal = null,Object? activityLevel = null,Object? calorieTarget = null,Object? heightCm = freezed,Object? goalWeightKg = freezed,}) {
  return _then(UserSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,activityLevel: null == activityLevel ? _self.activityLevel : activityLevel // ignore: cast_nullable_to_non_nullable
as String,calorieTarget: null == calorieTarget ? _self.calorieTarget : calorieTarget // ignore: cast_nullable_to_non_nullable
as int,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,goalWeightKg: freezed == goalWeightKg ? _self.goalWeightKg : goalWeightKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettings].
extension UserSettingsPatterns on UserSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettings value)  $default,){
final _that = this;
switch (_that) {
case _UserSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettings value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? email,  String? name,  String goal, @JsonKey(name: 'activity_level')  String activityLevel, @JsonKey(name: 'calorie_target')  int calorieTarget, @JsonKey(name: 'height_cm')  double? heightCm, @JsonKey(name: 'goal_weight_kg')  double? goalWeightKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.goal,_that.activityLevel,_that.calorieTarget,_that.heightCm,_that.goalWeightKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? email,  String? name,  String goal, @JsonKey(name: 'activity_level')  String activityLevel, @JsonKey(name: 'calorie_target')  int calorieTarget, @JsonKey(name: 'height_cm')  double? heightCm, @JsonKey(name: 'goal_weight_kg')  double? goalWeightKg)  $default,) {final _that = this;
switch (_that) {
case _UserSettings():
return $default(_that.id,_that.email,_that.name,_that.goal,_that.activityLevel,_that.calorieTarget,_that.heightCm,_that.goalWeightKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? email,  String? name,  String goal, @JsonKey(name: 'activity_level')  String activityLevel, @JsonKey(name: 'calorie_target')  int calorieTarget, @JsonKey(name: 'height_cm')  double? heightCm, @JsonKey(name: 'goal_weight_kg')  double? goalWeightKg)?  $default,) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.goal,_that.activityLevel,_that.calorieTarget,_that.heightCm,_that.goalWeightKg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSettings implements UserSettings {
  const _UserSettings({required this.id, this.email, this.name, this.goal = 'maintain', @JsonKey(name: 'activity_level') this.activityLevel = 'moderate', @JsonKey(name: 'calorie_target') this.calorieTarget = 2200, @JsonKey(name: 'height_cm') this.heightCm, @JsonKey(name: 'goal_weight_kg') this.goalWeightKg});
  factory _UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

@override final  String id;
@override final  String? email;
@override final  String? name;
@override@JsonKey() final  String goal;
@override@JsonKey(name: 'activity_level') final  String activityLevel;
@override@JsonKey(name: 'calorie_target') final  int calorieTarget;
@override@JsonKey(name: 'height_cm') final  double? heightCm;
@override@JsonKey(name: 'goal_weight_kg') final  double? goalWeightKg;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsCopyWith<_UserSettings> get copyWith => __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.activityLevel, activityLevel) || other.activityLevel == activityLevel)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.goalWeightKg, goalWeightKg) || other.goalWeightKg == goalWeightKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,name,goal,activityLevel,calorieTarget,heightCm,goalWeightKg);
}

@override
String toString() {
    return 'UserSettings(id: $id, email: $email, name: $name, goal: $goal, activityLevel: $activityLevel, calorieTarget: $calorieTarget, heightCm: $heightCm, goalWeightKg: $goalWeightKg)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsCopyWith<$Res> implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(_UserSettings value, $Res Function(_UserSettings) _then) = __$UserSettingsCopyWithImpl;
@override @useResult
$Res call({
 String id, String? email, String? name, String goal,@JsonKey(name: 'activity_level') String activityLevel,@JsonKey(name: 'calorie_target') int calorieTarget,@JsonKey(name: 'height_cm') double? heightCm,@JsonKey(name: 'goal_weight_kg') double? goalWeightKg
});




}
/// @nodoc
class __$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(this._self, this._then);

  final _UserSettings _self;
  final $Res Function(_UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,Object? name = freezed,Object? goal = null,Object? activityLevel = null,Object? calorieTarget = null,Object? heightCm = freezed,Object? goalWeightKg = freezed,}) {
  return _then(_UserSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,activityLevel: null == activityLevel ? _self.activityLevel : activityLevel // ignore: cast_nullable_to_non_nullable
as String,calorieTarget: null == calorieTarget ? _self.calorieTarget : calorieTarget // ignore: cast_nullable_to_non_nullable
as int,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,goalWeightKg: freezed == goalWeightKg ? _self.goalWeightKg : goalWeightKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
