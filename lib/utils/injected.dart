import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/services/client_service.dart';
import 'package:jmorder_app/services/order_service.dart';
import 'package:jmorder_app/services/profile_service.dart';
import 'package:jmorder_app/states/selected_client_state.dart';
import 'package:jmorder_app/states/selected_order_state.dart';
import 'package:jmorder_app/services/verification_service.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final authService = RM.inject(() => AuthService());
final profileService = RM.inject(() => ProfileService());
final verificationService = RM.inject(() => VerificationService());
final clientService = RM.inject(() => ClientService());
final selectedClientState = RM.inject(() => SelectedClientState());
final orderService = RM.inject(() => OrderService());
final selectedOrderState = RM.inject(() => SelectedOrderState());
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
