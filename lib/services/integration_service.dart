import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/payloads/response/request_verification_response.dart';

import 'jmo_api_service.dart';

class VerificationService {
  JmoApiService get apiService => GetIt.I.get<JmoApiService>();

  Future<RequestVerificationResponse> requestVerification(String phone) async {
    try {
      var response = await apiService
          .getClient()
          .post('/auth/registration/verify', data: {"phone": phone});
      return RequestVerificationResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) throw PhoneNumberNotFoundException();
      throw UnexpectedIntegrationException();
    }
  }

  Future<Auth> performVerification(
      String id, String otp, String authDetail) async {
    var response = await apiService.getClient().patch(
        '/auth/registration/verify',
        data: {"id": id, "otp": otp, "authDetail": authDetail});
    if (response.statusCode == HttpStatus.noContent) {
      throw ConnectedUserNotFoundException();
    }
    Auth auth = Auth.fromJson(response.data);
    apiService.setAuthorizationHeader(auth);
    return auth;
  }
}

class UnexpectedIntegrationException extends DioError {}

class PhoneNumberNotFoundException extends DioError {}

class ConnectedUserNotFoundException implements Exception {
  String _message;
  ConnectedUserNotFoundException(
      [String message = 'Connected user does NOT exist']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
