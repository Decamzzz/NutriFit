// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiaryEntry {

 String? get id;@JsonKey(name: 'user_id') String? get userId; String get date;@JsonKey(name: 'meal_type') String get mealType;@JsonKey(name: 'food_name') String get foodName; double get grams; double get kcal; double get protein; double get carbs; double get fat; String get source;
/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryEntryCopyWith<DiaryEntry> get copyWith => _$DiaryEntryCopyWithImpl<DiaryEntry>(this as DiaryEntry, _$identity);

  /// Serializes this DiaryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DiaryEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.mealType, _this.mealType) || other.mealType == _this.mealType)&&(identical(other.foodName, _this.foodName) || other.foodName == _this.foodName)&&(identical(other.grams, _this.grams) || other.grams == _this.grams)&&(identical(other.kcal, _this.kcal) || other.kcal == _this.kcal)&&(identical(other.protein, _this.protein) || other.protein == _this.protein)&&(identical(other.carbs, _this.carbs) || other.carbs == _this.carbs)&&(identical(other.fat, _this.fat) || other.fat == _this.fat)&&(identical(other.source, _this.source) || other.source == _this.source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DiaryEntry;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.date,_this.mealType,_this.foodName,_this.grams,_this.kcal,_this.protein,_this.carbs,_this.fat,_this.source);
}

@override
String toString() {
  final _this = this as DiaryEntry;
  return 'DiaryEntry(id: ${_this.id}, userId: ${_this.userId}, date: ${_this.date}, mealType: ${_this.mealType}, foodName: ${_this.foodName}, grams: ${_this.grams}, kcal: ${_this.kcal}, protein: ${_this.protein}, carbs: ${_this.carbs}, fat: ${_this.fat}, source: ${_this.source})';
}


}

/// @nodoc
abstract mixin class $DiaryEntryCopyWith<$Res>  {
  factory $DiaryEntryCopyWith(DiaryEntry value, $Res Function(DiaryEntry) _then) = _$DiaryEntryCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'user_id') String? userId, String date,@JsonKey(name: 'meal_type') String mealType,@JsonKey(name: 'food_name') String foodName, double grams, double kcal, double protein, double carbs, double fat, String source
});




}
/// @nodoc
class _$DiaryEntryCopyWithImpl<$Res>
    implements $DiaryEntryCopyWith<$Res> {
  _$DiaryEntryCopyWithImpl(this._self, this._then);

  final DiaryEntry _self;
  final $Res Function(DiaryEntry) _then;

/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? date = null,Object? mealType = null,Object? foodName = null,Object? grams = null,Object? kcal = null,Object? protein = null,Object? carbs = null,Object? fat = null,Object? source = null,}) {
  return _then(DiaryEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as String,foodName: null == foodName ? _self.foodName : foodName // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as double,protein: null == protein ? _self.protein : protein // ignore: cast_nullable_to_non_nullable
as double,carbs: null == carbs ? _self.carbs : carbs // ignore: cast_nullable_to_non_nullable
as double,fat: null == fat ? _self.fat : fat // ignore: cast_nullable_to_non_nullable
as double,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DiaryEntry].
extension DiaryEntryPatterns on DiaryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryEntry value)  $default,){
final _that = this;
switch (_that) {
case _DiaryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_id')  String? userId,  String date, @JsonKey(name: 'meal_type')  String mealType, @JsonKey(name: 'food_name')  String foodName,  double grams,  double kcal,  double protein,  double carbs,  double fat,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.mealType,_that.foodName,_that.grams,_that.kcal,_that.protein,_that.carbs,_that.fat,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_id')  String? userId,  String date, @JsonKey(name: 'meal_type')  String mealType, @JsonKey(name: 'food_name')  String foodName,  double grams,  double kcal,  double protein,  double carbs,  double fat,  String source)  $default,) {final _that = this;
switch (_that) {
case _DiaryEntry():
return $default(_that.id,_that.userId,_that.date,_that.mealType,_that.foodName,_that.grams,_that.kcal,_that.protein,_that.carbs,_that.fat,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'user_id')  String? userId,  String date, @JsonKey(name: 'meal_type')  String mealType, @JsonKey(name: 'food_name')  String foodName,  double grams,  double kcal,  double protein,  double carbs,  double fat,  String source)?  $default,) {final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.mealType,_that.foodName,_that.grams,_that.kcal,_that.protein,_that.carbs,_that.fat,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiaryEntry implements DiaryEntry {
  const _DiaryEntry({this.id, @JsonKey(name: 'user_id') this.userId, required this.date, @JsonKey(name: 'meal_type') required this.mealType, @JsonKey(name: 'food_name') required this.foodName, this.grams = 100, this.kcal = 0, this.protein = 0, this.carbs = 0, this.fat = 0, this.source = 'manual'});
  factory _DiaryEntry.fromJson(Map<String, dynamic> json) => _$DiaryEntryFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'user_id') final  String? userId;
@override final  String date;
@override@JsonKey(name: 'meal_type') final  String mealType;
@override@JsonKey(name: 'food_name') final  String foodName;
@override@JsonKey() final  double grams;
@override@JsonKey() final  double kcal;
@override@JsonKey() final  double protein;
@override@JsonKey() final  double carbs;
@override@JsonKey() final  double fat;
@override@JsonKey() final  String source;

/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryEntryCopyWith<_DiaryEntry> get copyWith => __$DiaryEntryCopyWithImpl<_DiaryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiaryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&(identical(other.foodName, foodName) || other.foodName == foodName)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.kcal, kcal) || other.kcal == kcal)&&(identical(other.protein, protein) || other.protein == protein)&&(identical(other.carbs, carbs) || other.carbs == carbs)&&(identical(other.fat, fat) || other.fat == fat)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,date,mealType,foodName,grams,kcal,protein,carbs,fat,source);
}

@override
String toString() {
    return 'DiaryEntry(id: $id, userId: $userId, date: $date, mealType: $mealType, foodName: $foodName, grams: $grams, kcal: $kcal, protein: $protein, carbs: $carbs, fat: $fat, source: $source)';
}


}

/// @nodoc
abstract mixin class _$DiaryEntryCopyWith<$Res> implements $DiaryEntryCopyWith<$Res> {
  factory _$DiaryEntryCopyWith(_DiaryEntry value, $Res Function(_DiaryEntry) _then) = __$DiaryEntryCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'user_id') String? userId, String date,@JsonKey(name: 'meal_type') String mealType,@JsonKey(name: 'food_name') String foodName, double grams, double kcal, double protein, double carbs, double fat, String source
});




}
/// @nodoc
class __$DiaryEntryCopyWithImpl<$Res>
    implements _$DiaryEntryCopyWith<$Res> {
  __$DiaryEntryCopyWithImpl(this._self, this._then);

  final _DiaryEntry _self;
  final $Res Function(_DiaryEntry) _then;

/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? date = null,Object? mealType = null,Object? foodName = null,Object? grams = null,Object? kcal = null,Object? protein = null,Object? carbs = null,Object? fat = null,Object? source = null,}) {
  return _then(_DiaryEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as String,foodName: null == foodName ? _self.foodName : foodName // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as double,protein: null == protein ? _self.protein : protein // ignore: cast_nullable_to_non_nullable
as double,carbs: null == carbs ? _self.carbs : carbs // ignore: cast_nullable_to_non_nullable
as double,fat: null == fat ? _self.fat : fat // ignore: cast_nullable_to_non_nullable
as double,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
