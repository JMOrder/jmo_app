import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/services/exceptions/auth_service_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/bloc/auth/auth_state.dart';
import 'package:jmorder_app/services/kakao_service.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:logger/logger.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = GetIt.I.get<AuthService>();
  final KakaoService _kakaoService = GetIt.I.get<KakaoService>();
  final Logger _logger = Logger();

  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AppLoaded) {
        yield AuthRequestState();
        AccessToken accessToken = await _kakaoService.getToken();
        _logger.d(accessToken);
        await _authService.refreshToken();
        yield LoginSuccessState(auth: _authService.auth);
      } else if (event is LoginSubmitted) {
        yield AuthRequestState();
        await _authService.login(
          event.email,
          event.password,
        );
        yield LoginSuccessState(auth: _authService.auth);
      } else if (event is LogoutSubmitted) {
        yield AuthRequestState();
        await _authService.logout();
        yield LogoutSuccessState();
      } else if (event is SignUpSubmitted) {
        yield AuthRequestState();
        await _authService.signUp(
          email: event.email,
          phone: event.phone,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
        );
        yield SignUpSuccessState();
      } else {
        throw new Exception('${event.runtimeType} is NOT implemented');
      }
    } on LoginFailedException catch (e) {
      yield LoginFailureState(error: e);
    } on LogoutFailedException catch (e) {
      yield LogoutFailureState(error: e);
    } on RefreshTokenFailedException {
      yield LoginWaitingState();
    } on SignUpFailedException catch (e) {
      yield SignUpFailureState(error: e);
    } on UnexpectedAuthException catch (e) {
      yield UnexpectedFailureState(error: e);
    }
  }
}
