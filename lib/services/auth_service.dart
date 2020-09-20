import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/models/profile.dart';
import 'package:jmorder_app/services/exceptions/auth_service_exception.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import 'api_service.dart';

class AuthService {
  Auth _auth;
  Profile _profile;

  AuthService()
      : this._auth = Auth(),
        this._profile = Profile();

  Auth get auth => _auth;
  Profile get profile => _profile;
  String get authorizationHeader => "${_auth?.type} ${_auth?.token}";

  bool hasAuth() {
    return _auth != null;
  }

  ApiService get _apiService => GetIt.I.get<ApiService>();

  Future<void> login(email, password) async {
    try {
      var response = await _apiService.getClient().post('/auth', data: {
        "email": email,
        "password": password,
      });

      _auth = Auth.fromJson(response.data);
      final storage = new FlutterSecureStorage();
      storage.write(key: "jwt", value: _auth.token);
      var profileResponse = await _apiService.getClient().get('/profile');
      _profile = Profile.fromJson(profileResponse.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized)
        throw LoginFailedException();
      throw UnexpectedAuthException();
    }
  }

  Future<void> refreshToken() async {
    try {
      final storage = new FlutterSecureStorage();
      String jwt = await storage.read(key: "jwt");
      _auth = Auth(token: jwt, type: "Bearer");
      var response = await _apiService.getClient().post('/auth/refresh-token');
      _auth = Auth.fromJson(response.data);
      storage.write(key: "jwt", value: _auth.token);
      var profileResponse = await _apiService.getClient().get('/profile');
      _profile = Profile.fromJson(profileResponse.data);
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
      await storage.delete(key: "jwt");
      await _apiService.getClient().delete('/auth');
      _auth = null;
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
      await _apiService.getClient().post('/auth/register', data: {
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
}
