// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FoodEstimate {

 String get name; double get grams; double get kcal; double get protein; double get carbs; double get fat; double get confidence;
/// Create a copy of FoodEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodEstimateCopyWith<FoodEstimate> get copyWith => _$FoodEstimateCopyWithImpl<FoodEstimate>(this as FoodEstimate, _$identity);

  /// Serializes this FoodEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FoodEstimate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodEstimate&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.grams, _this.grams) || other.grams == _this.grams)&&(identical(other.kcal, _this.kcal) || other.kcal == _this.kcal)&&(identical(other.protein, _this.protein) || other.protein == _this.protein)&&(identical(other.carbs, _this.carbs) || other.carbs == _this.carbs)&&(identical(other.fat, _this.fat) || other.fat == _this.fat)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FoodEstimate;
  return Object.hash(runtimeType,_this.name,_this.grams,_this.kcal,_this.protein,_this.carbs,_this.fat,_this.confidence);
}

@override
String toString() {
  final _this = this as FoodEstimate;
  return 'FoodEstimate(name: ${_this.name}, grams: ${_this.grams}, kcal: ${_this.kcal}, protein: ${_this.protein}, carbs: ${_this.carbs}, fat: ${_this.fat}, confidence: ${_this.confidence})';
}


}

/// @nodoc
abstract mixin class $FoodEstimateCopyWith<$Res>  {
  factory $FoodEstimateCopyWith(FoodEstimate value, $Res Function(FoodEstimate) _then) = _$FoodEstimateCopyWithImpl;
@useResult
$Res call({
 String name, double grams, double kcal, double protein, double carbs, double fat, double confidence
});




}
/// @nodoc
class _$FoodEstimateCopyWithImpl<$Res>
    implements $FoodEstimateCopyWith<$Res> {
  _$FoodEstimateCopyWithImpl(this._self, this._then);

  final FoodEstimate _self;
  final $Res Function(FoodEstimate) _then;

/// Create a copy of FoodEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? grams = null,Object? kcal = null,Object? protein = null,Object? carbs = null,Object? fat = null,Object? confidence = null,}) {
  return _then(FoodEstimate(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as double,protein: null == protein ? _self.protein : protein // ignore: cast_nullable_to_non_nullable
as double,carbs: null == carbs ? _self.carbs : carbs // ignore: cast_nullable_to_non_nullable
as double,fat: null == fat ? _self.fat : fat // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodEstimate].
extension FoodEstimatePatterns on FoodEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodEstimate value)  $default,){
final _that = this;
switch (_that) {
case _FoodEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _FoodEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double grams,  double kcal,  double protein,  double carbs,  double fat,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodEstimate() when $default != null:
return $default(_that.name,_that.grams,_that.kcal,_that.protein,_that.carbs,_that.fat,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double grams,  double kcal,  double protein,  double carbs,  double fat,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _FoodEstimate():
return $default(_that.name,_that.grams,_that.kcal,_that.protein,_that.carbs,_that.fat,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double grams,  double kcal,  double protein,  double carbs,  double fat,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _FoodEstimate() when $default != null:
return $default(_that.name,_that.grams,_that.kcal,_that.protein,_that.carbs,_that.fat,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodEstimate implements FoodEstimate {
  const _FoodEstimate({required this.name, this.grams = 100, this.kcal = 0, this.protein = 0, this.carbs = 0, this.fat = 0, this.confidence = 0.5});
  factory _FoodEstimate.fromJson(Map<String, dynamic> json) => _$FoodEstimateFromJson(json);

@override final  String name;
@override@JsonKey() final  double grams;
@override@JsonKey() final  double kcal;
@override@JsonKey() final  double protein;
@override@JsonKey() final  double carbs;
@override@JsonKey() final  double fat;
@override@JsonKey() final  double confidence;

/// Create a copy of FoodEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodEstimateCopyWith<_FoodEstimate> get copyWith => __$FoodEstimateCopyWithImpl<_FoodEstimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodEstimateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodEstimate&&(identical(other.name, name) || other.name == name)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.kcal, kcal) || other.kcal == kcal)&&(identical(other.protein, protein) || other.protein == protein)&&(identical(other.carbs, carbs) || other.carbs == carbs)&&(identical(other.fat, fat) || other.fat == fat)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,grams,kcal,protein,carbs,fat,confidence);
}

@override
String toString() {
    return 'FoodEstimate(name: $name, grams: $grams, kcal: $kcal, protein: $protein, carbs: $carbs, fat: $fat, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$FoodEstimateCopyWith<$Res> implements $FoodEstimateCopyWith<$Res> {
  factory _$FoodEstimateCopyWith(_FoodEstimate value, $Res Function(_FoodEstimate) _then) = __$FoodEstimateCopyWithImpl;
@override @useResult
$Res call({
 String name, double grams, double kcal, double protein, double carbs, double fat, double confidence
});




}
/// @nodoc
class __$FoodEstimateCopyWithImpl<$Res>
    implements _$FoodEstimateCopyWith<$Res> {
  __$FoodEstimateCopyWithImpl(this._self, this._then);

  final _FoodEstimate _self;
  final $Res Function(_FoodEstimate) _then;

/// Create a copy of FoodEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? grams = null,Object? kcal = null,Object? protein = null,Object? carbs = null,Object? fat = null,Object? confidence = null,}) {
  return _then(_FoodEstimate(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as double,protein: null == protein ? _self.protein : protein // ignore: cast_nullable_to_non_nullable
as double,carbs: null == carbs ? _self.carbs : carbs // ignore: cast_nullable_to_non_nullable
as double,fat: null == fat ? _self.fat : fat // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
