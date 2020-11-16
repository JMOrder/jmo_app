import 'package:equatable/equatable.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:meta/meta.dart';

abstract class IntegrationEvent extends Equatable {}

class CheckIntegration extends IntegrationEvent {
  final String phone;

  CheckIntegration({@required this.phone});

  @override
  List<Object> get props => [phone];
}

class PerformIntegration extends IntegrationEvent {
  final String phone;
  final Auth auth;

  PerformIntegration({@required this.phone, @required this.auth});

  @override
  List<Object> get props => [];
}
