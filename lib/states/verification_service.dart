import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jmorder_app/models/verification.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/utils/service_locator.dart';

class VerificationService {
  Verification model;

  Future<void> requestVerification(String phone) async {
    var response = await getIt<JmoApiService>()
        .getClient()
        .post('/auth/verification', data: {"phone": phone});
    model = Verification.fromJson(response.data);
  }

  Future<void> performVerification(String otp) async {
    var response = await getIt<JmoApiService>()
        .getClient()
        .patch('/auth/verification', data: {
      "id": model.id,
      "otp": otp,
      "authDetail": authService.state.auth.authDetail
    });
    if (response.statusCode == HttpStatus.noContent) {
      throw ConnectedUserNotFoundException();
    }
    authService.setState((s) => s.refreshToken());
  }
}

class PhoneNumberNotFoundException extends DioError {}

class UnexpectedIntegrationException extends DioError {}

class ConnectedUserNotFoundException implements Exception {}
