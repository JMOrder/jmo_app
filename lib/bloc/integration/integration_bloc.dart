import 'package:jmorder_app/bloc/integration/integration_event.dart';
import 'package:jmorder_app/bloc/integration/integration_state.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/models/connected_user.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/services/integration_service.dart';

class IntegrationBloc extends Bloc<IntegrationEvent, IntegrationState> {
  final AuthService _authService = GetIt.I.get<AuthService>();
  final IntegrationService _integrationService =
      GetIt.I.get<IntegrationService>();

  IntegrationBloc(IntegrationState initialState) : super(initialState);

  @override
  Stream<IntegrationState> mapEventToState(IntegrationEvent event) async* {
    if (event is CheckIntegration) {
      yield CheckRequested();
      yield await _integrationService.checkIntegration(event.phone)
          ? IntegratableUserFound()
          : RegistrationRequired();
    }
    if (event is PerformIntegration) {
      yield PerformRequested();
      var data = await _integrationService.performIntegration(
        event.phone,
        event.auth.authDetail,
      );
      Auth auth = event.auth;
      auth.token = data["token"] as String;
      auth.connectedUser = ConnectedUser.fromJson(data["connectedUser"]);
      yield PerformSuccess(auth: auth);
    }
  }
}
