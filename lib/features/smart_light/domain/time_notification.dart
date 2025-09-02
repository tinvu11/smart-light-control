class TimeNotification {
  final bool isNotifiOn;
  final String timeNotifi;

  TimeNotification({required this.isNotifiOn, required this.timeNotifi});

  factory TimeNotification.fromMap(Map<dynamic, dynamic> map) {
    return TimeNotification(
      isNotifiOn: map['isNotifiOn'] == true,
      timeNotifi: map['timeNotifi'] ?? '',
    );
  }
}
