import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smartlight/core/service/firebase_service.dart';
import 'package:flutter_smartlight/features/smart_light/domain/control.dart';
import 'package:flutter_smartlight/features/smart_light/domain/led_control.dart';
import 'package:flutter_smartlight/features/smart_light/domain/promodoro.dart';

// StreamProvider theo dõi trạng thái của đèn
final ledControlProvider = StreamProvider<LedControl>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);

  return firebaseService.ledControlStream
      .map((event) {
        if (event.snapshot.value == null) {
          // Trả về giá trị mặc định nếu không có dữ liệu
          return LedControl(
            control: Control(
              doSangCuaDen: '50',
              nutDoiMau: '0',
              nutNguon: '0',
              nutTuDongSang: '0',
            ),
            promodoro: Promodoro(
              isNotifiOn: '0',
              timeWork: '17:00',
              timeBreak: '08:00',
            ),
            timeUse: [],
          );
        }
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        return LedControl.fromJson(data);
      })
      .handleError((error) {
        // Trả về giá trị mặc định khi có lỗi
        return LedControl(
          control: Control(
            doSangCuaDen: '50',
            nutDoiMau: '0',
            nutNguon: '0',
            nutTuDongSang: '0',
          ),
          promodoro: Promodoro(
            isNotifiOn: '0',
            timeWork: '17:00',
            timeBreak: '08:00',
          ),
          timeUse: [],
        );
      });
});

// Provider để thực hiện các hành động
class LedController extends Notifier<void> {
  @override
  void build() {}

  FirebaseService get _firebaseService => ref.read(firebaseServiceProvider);

  void toggleLight(bool isOn) {
    _firebaseService.updateControl({'nutNguon': isOn ? '1' : '0'});
  }

  void togglePromodoro(bool isOn) {
    _firebaseService.updatePromodoro({'isNotifiOn': isOn ? '1' : '0'});
  }

  void toggleAutoBrightness(bool isAuto) {
    _firebaseService.updateControl({'nutTuDongSang': isAuto ? '1' : '0'});
  }

  void changeColor(int colorIndex) {
    _firebaseService.updateControl({'nutDoiMau': colorIndex.toString()});
  }

  void changePromodoro({required int timeWork, required int timeBreak}) {
    _firebaseService.updatePromodoro({
      'timeWork': timeWork.toString(),
      'timeBreak': timeBreak.toString(),
    });
  }

  void changeBrightness(int value) {
    // final brightness255 = ((value * 255) ~/ 100).toString();
    // print('Brightness set to: $brightness255 - $value');
    _firebaseService.updateControl({'doSangCuaDen': value.toString()});
  }
}

final ledControllerProvider = NotifierProvider<LedController, void>(
  LedController.new,
);
