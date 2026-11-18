/// Body data collected when creating an account. The backend stores it in the
/// profile (height, goal, goal weight) and as the first weight log.
class BodyProfileInput {
  const BodyProfileInput({
    required this.weightKg,
    required this.heightCm,
    required this.goal,
    required this.goalWeightKg,
  });

  final double weightKg;
  final double heightCm;

  /// 'lose' | 'maintain' | 'gain'
  final String goal;
  final double goalWeightKg;
}
