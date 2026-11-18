import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_log.freezed.dart';
part 'weight_log.g.dart';

/// One row of public.weight_logs: the weight of a user on a given day.
/// [date] is a `yyyy-MM-dd` string (Postgres `date`).
@freezed
abstract class WeightLog with _$WeightLog {
  const factory WeightLog({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    required String date,
    @JsonKey(name: 'weight_kg') required double weightKg,
  }) = _WeightLog;

  factory WeightLog.fromJson(Map<String, dynamic> json) =>
      _$WeightLogFromJson(json);
}
