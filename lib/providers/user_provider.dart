import 'package:fingerprint_app/services/finger_print_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRep = Provider((ref) => FingerPrintService());

final userProvider = FutureProvider.autoDispose((ref) {
  final res = ref.read(userRep).getUserWithHistory();
  return res;
});

final userHistoryProvider = FutureProvider((ref) {
  final res = ref.read(userRep).getUserWithHistory();
  return res;
});
