import 'package:equatable/equatable.dart';
import 'package:jmorder_app/models/auth.dart';
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
