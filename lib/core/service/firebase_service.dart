import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  // LED_CONTROL
  DatabaseReference get ledControlRef => _db.child('LED_CONTROL');
  Stream<DatabaseEvent> get ledControlStream => ledControlRef.onValue;

  // Nhánh con
  DatabaseReference get controlRef => ledControlRef.child('control');
  DatabaseReference get promodoroRef => ledControlRef.child('promodoro');
  DatabaseReference get timeUseRef => ledControlRef.child('timeUse');

  Future<void> updateControl(Map<String, dynamic> values) =>
      controlRef.update(values);

  Future<void> updatePromodoro(Map<String, dynamic> values) =>
      promodoroRef.update(values);
}

// Provider để cung cấp một instance duy nhất của FirebaseService
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});
