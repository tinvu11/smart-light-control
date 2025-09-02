// class LedControl {
//   final double brightness; // 0-100
//   final bool isLightOn;
//   final bool isAutoBrightness;
//   final int colorIndex; // 0 for Vàng, 1 for Trắng

//   LedControl({
//     required this.brightness,
//     required this.isLightOn,
//     required this.isAutoBrightness,
//     required this.colorIndex,
//   });

//   factory LedControl.fromMap(Map<dynamic, dynamic> map) {
//     return LedControl(
//       brightness:
//           (double.tryParse(map['doSangCuaDen']?.toString() ?? '0') ?? 0) *
//           100 /
//           255,
//       isLightOn: map['nutNguon'] == '1',
//       isAutoBrightness: map['nutTuDongSang'] == '1',
//       colorIndex: int.tryParse(map['nutDoiMau']?.toString() ?? '0') ?? 0,
//     );
//   }
// }

import 'package:flutter_smartlight/features/smart_light/domain/control.dart';
import 'package:flutter_smartlight/features/smart_light/domain/promodoro.dart';
import 'package:flutter_smartlight/features/smart_light/domain/time_use.dart';

class LedControl {
  final Control control;
  final Promodoro promodoro;
  final List<TimeUseEntry> timeUse;

  LedControl({
    required this.control,
    required this.promodoro,
    required this.timeUse,
  });

  factory LedControl.fromJson(Map<String, dynamic> json) {
    final timeUseMap = Map<String, dynamic>.from(json['timeUse'] ?? {});
    final timeUseList = timeUseMap.entries
        .map((e) => TimeUseEntry.fromMap(e))
        .toList();

    return LedControl(
      control: Control.fromJson(
        Map<String, dynamic>.from(json['control'] ?? {}),
      ),
      promodoro: Promodoro.fromJson(
        Map<String, dynamic>.from(json['promodoro'] ?? {}),
      ),
      timeUse: timeUseList,
    );
  }

  Map<String, dynamic> toJson() => {
    'control': control.toJson(),
    'promodoro': promodoro.toJson(),
    'timeUse': {
      for (var e in timeUse) e.date.toIso8601String().split("T").first: e.value,
    },
  };
}
