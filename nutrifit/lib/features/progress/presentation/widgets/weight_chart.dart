import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/weight_chart_data.dart';

/// Line chart of the weight over time with an optional dashed goal line.
class WeightChart extends StatelessWidget {
  const WeightChart({super.key, required this.data, required this.goalLabel});

  final WeightChartData data;
  final String goalLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant);
    final goal = data.goalKg;

    return AspectRatio(
      aspectRatio: 1.6,
      child: LineChart(
        LineChartData(
          minX: data.minX,
          maxX: data.maxX,
          minY: data.minY,
          maxY: data.maxY,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: data.yInterval,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: scheme.outlineVariant, strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                interval: data.yInterval,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text(value.toStringAsFixed(0), style: labelStyle),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: data.xInterval,
                getTitlesWidget: (value, meta) {
                  // Only label real days (never the empty padding).
                  if (value < 0 || value > data.lastX) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      shortDate(data.dateAt(value)),
                      style: labelStyle,
                    ),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => [
                for (final spot in spots)
                  LineTooltipItem(
                    '${spot.y.toStringAsFixed(1)} kg\n'
                    '${shortDate(data.dateAt(spot.x))}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              if (goal != null)
                HorizontalLine(
                  y: goal,
                  color: AppColors.fat,
                  strokeWidth: 1.5,
                  dashArray: [6, 4],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: labelStyle?.copyWith(color: AppColors.fat),
                    labelResolver: (_) => goalLabel,
                  ),
                ),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [for (final p in data.points) FlSpot(p.x, p.y)],
              isCurved: true,
              preventCurveOverShooting: true,
              color: AppColors.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                      radius: 3.5,
                      color: AppColors.primary,
                      strokeWidth: 2,
                      strokeColor: scheme.surface,
                    ),
              ),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
