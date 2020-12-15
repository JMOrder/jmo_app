import 'package:equatable/equatable.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/payloads/request/register_request.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email, password;
  LoginSubmitted({
    @required this.email,
    @required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class KakaoLoginSubmitted extends AuthEvent {}

class LogoutSubmitted extends AuthEvent {}

class SignUpSubmitted extends AuthEvent {
  final String email, phone, password, firstName, lastName;

  SignUpSubmitted({
    @required this.email,
    @required this.phone,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
  });
  @override
  List<Object> get props => [email, phone, password, firstName, lastName];
}

class FetchProfile extends AuthEvent {
  final Auth auth;

  FetchProfile({@required this.auth});

  @override
  List<Object> get props => [auth];
}

class RequestVerification extends AuthEvent {
  final String phone;

  RequestVerification({@required this.phone});

  @override
  List<Object> get props => [phone];
}

class PerformVerification extends AuthEvent {
  final String id;
  final String otp;
  final String authDetail;

  PerformVerification(
      {@required this.id, @required this.otp, @required this.authDetail});

  @override
  List<Object> get props => [];
}

class SubmitRegister extends AuthEvent {
  final RegisterRequest registerRequest;

  SubmitRegister(this.registerRequest);
}
