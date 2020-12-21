import 'dart:convert';

import 'package:jmorder_app/states/auth_service.dart';
import 'package:jmorder_app/states/client_service.dart';
import 'package:jmorder_app/states/profile_service.dart';
import 'package:jmorder_app/states/verification_service.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final authService = RM.inject(() => AuthService());
final profileService = RM.inject(() => ProfileService());
final verificationService = RM.inject(() => VerificationService());
final clientService = RM.inject(() => ClientService());
final bottomNavigationState = RM.inject<int>(
  () => 0,
  persist: () => PersistState(
    key: "__bottomNavigation__",
    toJson: (index) => index.toString(),
    fromJson: (json) {
      return int.tryParse(json) ?? 0;
    },
  ),
);
