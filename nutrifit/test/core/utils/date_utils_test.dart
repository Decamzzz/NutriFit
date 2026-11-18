import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/utils/date_utils.dart';

void main() {
  test('weekDays returns Mon..Sun containing reference', () {
    final ref = DateTime(2026, 10, 7); // Wednesday
    final week = weekDays(ref);
    expect(week, hasLength(7));
    expect(week.first.weekday, 1);
    expect(week.last.weekday, 7);
    expect(ymd(week.first), '2026-10-05');
  });

  test('parseYmd, daysBetween and shortDate', () {
    expect(parseYmd('2026-11-05'), DateTime(2026, 11, 5));
    expect(daysBetween(DateTime(2026, 11, 1), DateTime(2026, 11, 8)), 7);
    expect(daysBetween(DateTime(2026, 12, 31), DateTime(2027, 1, 1)), 1);
    expect(daysBetween(DateTime(2026, 11, 8), DateTime(2026, 11, 1)), -7);
    expect(shortDate(DateTime(2026, 11, 5)), '5/11');
  });
}
