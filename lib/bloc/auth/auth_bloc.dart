import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/models/profile.dart';
import 'package:jmorder_app/payloads/response/request_verification_response.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/services/exceptions/auth_service_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/bloc/auth/auth_state.dart';
import 'package:jmorder_app/services/integration_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = GetIt.I.get<AuthService>();
  final VerificationService _integrationService =
      GetIt.I.get<VerificationService>();

  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AppLoaded) {
        yield AuthRequestState();
        Auth auth = await _authService.refreshToken();
        this.add(FetchProfile(auth: auth));
      } else if (event is LoginSubmitted) {
        yield AuthRequestState();
        Auth auth = await _authService.loginWithLocal(
          event.email,
          event.password,
        );
        this.add(FetchProfile(auth: auth));
      } else if (event is RequestVerification) {
        yield CheckRequested();
        RequestVerificationResponse requestVerificationResponse =
            await _integrationService.requestVerification(event.phone);

        yield WaitingForOTP(
            requestVerificationResponse: requestVerificationResponse);
      } else if (event is PerformVerification) {
        yield PerformRequested();
        try {
          Auth auth = await _integrationService.performVerification(
            event.id,
            event.otp,
            event.authDetail,
          );
          this.add(FetchProfile(auth: auth));
        } on ConnectedUserNotFoundException {
          yield RegistrationRequired(authDetail: event.authDetail);
        } on DioError catch (e) {
          if (e.response.statusCode == HttpStatus.unauthorized) {}
        }
      } else if (event is KakaoLoginSubmitted) {
        yield AuthRequestState();
        Auth auth = await _authService.loginWithKakao();
        if (auth == null) {
          yield LoginWaitingState();
        } else if (auth.connectedUser == null) {
          yield IntegrationRequiredState(auth: auth);
        } else {
          this.add(FetchProfile(auth: auth));
        }
      } else if (event is FetchProfile) {
        Profile profile = await _authService.fetchProfile();
        yield LoginSuccessState(auth: event.auth, profile: profile);
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
    } on DioError catch (e) {
      yield UnexpectedFailureState(error: e);
    }
  }
}
