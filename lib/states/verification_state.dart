import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/verification.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/utils/injected.dart';

class VerificationState {
  Verification model;

  Future<void> requestVerification(String phone) async {
    this.model = await GetIt.I.get<AuthService>().requestVerification(phone);
  }

  Future<void> performVerification(String otp) async {
    final auth = await GetIt.I
        .get<AuthService>()
        .performVerification(model.id, otp, authState.state.model.authDetail);
    authState.setState((s) => s.model = auth);
  }
}
