import 'package:jmorder_app/states/auth_state.dart';
import 'package:jmorder_app/states/verification_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final authState = RM.inject(() => AuthState());
final verificationState = RM.inject(() => VerificationState());
