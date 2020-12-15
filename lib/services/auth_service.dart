import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/models/profile.dart';
import 'package:jmorder_app/services/exceptions/auth_service_exception.dart';
import 'package:kakao_flutter_sdk/auth.dart';

import 'jmo_api_service.dart';

class AuthService {
  Profile profile;
  bool _isKakaoInstalled = false;

  JmoApiService get apiService => GetIt.I.get<JmoApiService>();

  Future init() async {
    KakaoContext.clientId = DotEnv().env['KAKAO_CLIENT_ID'];
    this._isKakaoInstalled = await isKakaoTalkInstalled();
  }

  Future<Auth> loginWithKakao() async {
    String authCode;
    try {
      authCode = this._isKakaoInstalled
          ? await AuthCodeClient.instance.requestWithTalk()
          : await AuthCodeClient.instance.request();
    } catch (e) {
      return null;
    }

    var response = await apiService.getClient().post("/auth/kakao", data: {
      "code": authCode,
      "redirectUri": "kakao${DotEnv().env['KAKAO_CLIENT_ID']}://oauth"
    });
    Auth auth = Auth.fromJson(response.data);
    AccessTokenResponse accessTokenResponse =
        AccessTokenResponse.fromJson(response.data["accessTokenResponse"]);
    apiService.setAuthorizationHeader(auth);
    AccessTokenStore.instance.toStore(accessTokenResponse);
    if (response.statusCode == HttpStatus.ok) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "JMO_JWT_TOKEN", value: auth.token);
    }
    return auth;
  }

  Future<Auth> loginWithLocal(email, password) async {
    try {
      var response = await apiService.getClient().post('/auth', data: {
        "email": email,
        "password": password,
      });

      Auth auth = Auth.fromJson(response.data);
      apiService.setAuthorizationHeader(auth);
      final storage = new FlutterSecureStorage();
      await storage.write(key: "JMO_JWT_TOKEN", value: auth.token);
      return auth;
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized)
        throw LoginFailedException();
      throw UnexpectedAuthException();
    }
  }

  Future<Auth> refreshToken() async {
    try {
      var response = await apiService.getClient().post('/auth/refresh-token');
      Auth auth = Auth.fromJson(response.data);
      apiService.setAuthorizationHeader(auth);
      final storage = new FlutterSecureStorage();
      await storage.write(key: "JMO_JWT_TOKEN", value: auth.token);
      await this.fetchProfile();
      return auth;
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        throw RefreshTokenFailedException();
      }

      throw UnexpectedAuthException();
    }
  }

  Future<void> logout() async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.delete(key: "JMO_JWT_TOKEN");
      await apiService.getClient().delete('/auth');
      apiService.clearAuthorizationHeader();
    } catch (e) {
      throw LogoutFailedException();
    }
  }

  Future<void> signUp({
    @required email,
    @required phone,
    @required password,
    @required firstName,
    @required lastName,
  }) async {
    try {
      await apiService.getClient().post('/auth/register', data: {
        "email": email,
        "phone": phone,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unprocessableEntity)
        throw SignUpFailedException();
      throw UnexpectedAuthException();
    }
  }

  Future<AccessToken> getKakaoAccessToken() {
    return AccessTokenStore.instance.fromStore();
  }

  Future<Profile> fetchProfile() async {
    try {
      var profileResponse = await this.apiService.getClient().get("/profile");
      this.profile = Profile.fromJson(profileResponse.data);
      return profile;
    } catch (e) {
      throw ProfileFetchFailedException();
    }
  }
}
