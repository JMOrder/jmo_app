import 'package:equatable/equatable.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/models/profile.dart';
import 'package:jmorder_app/payloads/response/request_verification_response.dart';
import 'package:jmorder_app/services/exceptions/auth_service_exception.dart';
import 'package:meta/meta.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthRequestState extends AuthState {}

class RefreshTokenSuccessState extends AuthState {}

class RefreshTokenFailureState extends AuthState {}

class LoginWaitingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final Auth auth;
  final Profile profile;

  LoginSuccessState({@required this.auth, @required this.profile});

  @override
  List<Object> get props => [auth];
}

class LoginFailureState extends AuthState {
  final AuthServiceException error;

  LoginFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}

class LogoutSuccessState extends AuthState {}

class LogoutFailureState extends AuthState {
  final AuthServiceException error;

  LogoutFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}

class SignUpSuccessState extends AuthState {}

class SignUpFailureState extends AuthState {
  final AuthServiceException error;

  SignUpFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}

class IntegrationRequiredState extends AuthState {
  final Auth auth;
  IntegrationRequiredState({@required this.auth});

  @override
  List<Object> get props => [auth];
}

class UnexpectedFailureState extends AuthState {
  final AuthServiceException error;

  UnexpectedFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}

class CheckRequested extends AuthState {}

class IntegratableUserFound extends AuthState {}

class WaitingForOTP extends AuthState {
  final RequestVerificationResponse requestVerificationResponse;

  WaitingForOTP({@required this.requestVerificationResponse});

  @override
  List<Object> get props => [requestVerificationResponse];
}

class IncorrectOTPReceived extends AuthState {}

class RegistrationRequired extends AuthState {
  final String authDetail;
  RegistrationRequired({@required this.authDetail});
}

class RegistrationRequested extends AuthState {}

class PerformRequested extends AuthState {}

class PerformSuccess extends AuthState {
  final Auth auth;

  PerformSuccess({@required this.auth});
}
