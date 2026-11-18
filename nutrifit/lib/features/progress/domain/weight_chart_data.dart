import 'dart:math' as math;

import '../../../core/utils/date_utils.dart';
import 'weight_log.dart';

/// A chart point: [x] = days since the first log, [y] = kilograms.
typedef ChartPoint = ({double x, double y});

/// Geometry for the weight line chart: points plus axis bounds/intervals
/// chosen so labels are whole numbers and nothing touches the edges.
class WeightChartData {
  const WeightChartData._({
    required this.points,
    required this.firstDate,
    required this.goalKg,
    required this.lastX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.yInterval,
    required this.xInterval,
  });

  /// [logs] must be non-empty and sorted oldest first
  /// (see `WeightSummary.logs`).
  factory WeightChartData.from({
    required List<WeightLog> logs,
    double? goalKg,
  }) {
    assert(logs.isNotEmpty, 'WeightChartData needs at least one log');
    final firstDate = parseYmd(logs.first.date);
    final points = <ChartPoint>[
      for (final log in logs)
        (
          x: daysBetween(firstDate, parseYmd(log.date)).toDouble(),
          y: log.weightKg,
        ),
    ];
    final lastX = points.last.x;
    final padX = math.max(1, (lastX * 0.04).ceil());

    final ys = <double>[...points.map((p) => p.y), if (goalKg != null) goalKg];
    final low = ys.reduce(math.min);
    final high = ys.reduce(math.max);
    final interval = _niceInterval(high - low);
    final minY = ((low - interval / 2) / interval).floorToDouble() * interval;
    final maxY = ((high + interval / 2) / interval).ceilToDouble() * interval;

    return WeightChartData._(
      points: points,
      firstDate: firstDate,
      goalKg: goalKg,
      lastX: lastX,
      maxX: lastX + padX,
      minY: minY,
      maxY: maxY,
      yInterval: interval,
      xInterval: math.max(1, ((lastX + padX) / 4).ceil()).toDouble(),
    );
  }

  final List<ChartPoint> points;
  final DateTime firstDate;
  final double? goalKg;

  /// X of the most recent log.
  final double lastX;
  final double maxX;
  final double minY;
  final double maxY;
  final double yInterval;
  final double xInterval;

  double get minX => 0;

  /// Calendar date for a chart x value.
  DateTime dateAt(double x) => DateTime(
    firstDate.year,
    firstDate.month,
    firstDate.day + x.round(),
  );

  static double _niceInterval(double range) {
    if (range <= 4) return 1;
    if (range <= 10) return 2;
    if (range <= 25) return 5;
    if (range <= 60) return 10;
    return 20;
  }
}
