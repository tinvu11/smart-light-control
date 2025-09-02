// class Promodoro {
//   bool isNotifiOn;
//   String timeStart;
//   String timeEnd;

//   Promodoro({
//     required this.isNotifiOn,
//     required this.timeStart,
//     required this.timeEnd,
//   });

//   factory Promodoro.fromMap(Map<dynamic, dynamic> map) {
//     return Promodoro(
//       isNotifiOn: map['isNotifiOn'] == true,
//       timeStart: map['timeStart'] ?? '08:00',
//       timeEnd: map['timeEnd'] ?? '17:00',
//     );
//   }
// }

class Promodoro {
  final String isNotifiOn;
  final String timeWork;
  final String timeBreak;

  Promodoro({
    required this.isNotifiOn,
    required this.timeBreak,
    required this.timeWork,
  });

  factory Promodoro.fromJson(Map<String, dynamic> json) {
    return Promodoro(
      isNotifiOn: json['isNotifiOn'] ?? '',
      timeWork: json['timeWork'] ?? '',
      timeBreak: json['timeBreak'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'isNotifiOn': isNotifiOn,
    'timeWork': timeWork,
    'timeBreak': timeBreak,
  };
}
