// import 'package:local_auth/local_auth.dart';

// class PermissionService {
//   final LocalAuthentication auth = LocalAuthentication();
//   static Future<bool> checkBiometricPermission() async {
//     try {
//       final bool didAuthenticate = await auth.authenticate(
//           localizedReason: 'Please authenticate to show account balance',
//           options: const AuthenticationOptions(useErrorDialogs: false));
//       return true;
//     } catch (e) {
//       throw Exception('Error to check permission : $e');
//     }
//   }
// }
