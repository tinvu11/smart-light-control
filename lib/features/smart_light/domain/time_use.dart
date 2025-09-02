class TimeUseEntry {
  final DateTime date;
  final int value;

  TimeUseEntry({required this.date, required this.value});

  factory TimeUseEntry.fromMap(MapEntry<String, dynamic> entry) {
    return TimeUseEntry(
      date: DateTime.parse(entry.key),
      value: entry.value as int,
    );
  }
}
