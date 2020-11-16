import 'package:equatable/equatable.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:meta/meta.dart';

abstract class IntegrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class IntegrationRequiredState extends IntegrationState {
  final Auth auth;
  IntegrationRequiredState({@required this.auth});

  @override
  List<Object> get props => [auth];
}

class CheckRequested extends IntegrationState {}

class IntegratableUserFound extends IntegrationState {}

class RegistrationRequired extends IntegrationState {}

class RegistrationRequested extends IntegrationState {}

class PerformRequested extends IntegrationState {}

class PerformSuccess extends IntegrationState {
  final Auth auth;

  PerformSuccess({@required this.auth});
}
