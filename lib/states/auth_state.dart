import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:jmorder_app/services/auth_service.dart';

class AuthState {
  Auth model;

  AuthState({this.model});

  Future<void> loginWithKakao() async {
    this.model = await GetIt.I.get<AuthService>().loginWithKakao();
  }

  Future<void> refreshToken() async {
    this.model = await GetIt.I.get<AuthService>().refreshToken();
  }
}
