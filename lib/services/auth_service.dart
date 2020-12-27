import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';
import 'package:jmorder_app/widgets/pages/main_page.dart';
import 'package:jmorder_app/widgets/pages/verification_page.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AuthService {
  Auth auth;

  String get authorization => auth.authorization;

  Future<void> loginWithKakao() async {
    try {
      KakaoContext.clientId = DotEnv().env['KAKAO_CLIENT_ID'];
      String authCode = await isKakaoTalkInstalled()
          ? await AuthCodeClient.instance.requestWithTalk()
          : await AuthCodeClient.instance.request();

      var response = await getIt<JmoApiService>()
          .getClient()
          .post("/auth/kakao", data: {
        "code": authCode,
        "redirectUri": "kakao${KakaoContext.clientId}://oauth"
      });
      AccessTokenResponse accessTokenResponse =
          AccessTokenResponse.fromJson(response.data["accessTokenResponse"]);
      AccessTokenStore.instance.toStore(accessTokenResponse);
      auth = Auth.fromJson(response.data);
      getIt<JmoApiService>().setAuthorizationHeader(auth.authorization);

      if (auth.token != null) {
        RM.navigate.toNamedAndRemoveUntil(MainPage.routeName);
      } else {
        RM.navigate.toNamed(VerificationPage.routeName);
      }
    } on PlatformException {
      print("User exitted OAuth Platform");
    }
  }

  Future<void> refreshToken() async {
    try {
      var response =
          await getIt<JmoApiService>().getClient().post('/auth/refresh-token');
      final storage = new FlutterSecureStorage();
      await storage.write(key: "JMO_JWT_TOKEN", value: response.data['token']);
      auth = Auth.fromJson(response.data);
      getIt<JmoApiService>().setAuthorizationHeader(auth.authorization);
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        throw RefreshTokenFailedException();
      }

      throw UnexpectedAuthException();
    }
  }

  Future<void> register(
      String email, String firstName, String lastName, String password) async {
    // TODO: JMO-9: Implement Registration Step when the user doesn't exist
  }

  Future<void> logout() async {
    try {
      final apiService = getIt<JmoApiService>();

      await apiService.getClient().delete('/auth');
      apiService.clearAuthorizationHeader();
      final storage = new FlutterSecureStorage();
      await storage.delete(key: "JMO_JWT_TOKEN");
      bottomNavigationState.deletePersistState();
    } catch (e) {
      throw LogoutFailedException();
    }
  }
}

class RefreshTokenFailedException implements Exception {}

class UnexpectedAuthException implements Exception {}

class LogoutFailedException implements Exception {}
