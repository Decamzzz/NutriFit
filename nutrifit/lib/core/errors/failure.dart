import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Unified error type returned by repositories.
@freezed
sealed class Failure with _$Failure {
  const factory Failure.network({String? message}) = NetworkFailure;
  const factory Failure.auth({String? message}) = AuthFailure;
  const factory Failure.validation({String? message}) = ValidationFailure;
  const factory Failure.unknown({String? message}) = UnknownFailure;
}

extension FailureMessage on Failure {
  String get message => when(
    network: (m) => m ?? 'Network error',
    auth: (m) => m ?? 'Auth error',
    validation: (m) => m ?? 'Validation error',
    unknown: (m) => m ?? 'Unknown error',
  );
}
