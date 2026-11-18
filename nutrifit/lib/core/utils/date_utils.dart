/// Date helpers for diary/progress features.
DateTime startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

String ymd(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// Monday..Sunday containing [reference].
List<DateTime> weekDays(DateTime reference) {
  final start = startOfDay(
    reference.subtract(Duration(days: reference.weekday - 1)),
  );
  return List.generate(7, (i) => start.add(Duration(days: i)));
}

/// Parses a `yyyy-MM-dd` string (as stored in Postgres `date` columns).
DateTime parseYmd(String value) {
  final parts = value.split('-').map(int.parse).toList();
  return DateTime(parts[0], parts[1], parts[2]);
}

/// Whole calendar days from [from] to [to] (negative when [to] is earlier).
/// Uses UTC so daylight-saving changes never shift the result.
int daysBetween(DateTime from, DateTime to) => DateTime.utc(
  to.year,
  to.month,
  to.day,
).difference(DateTime.utc(from.year, from.month, from.day)).inDays;

/// Compact day/month label (locale independent), e.g. `12/11`.
String shortDate(DateTime d) => '${d.day}/${d.month}';
