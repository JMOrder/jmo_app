import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/auth.dart';
import 'package:meta/meta.dart';
import 'package:jmorder_app/services/auth_service.dart';

class JmoApiServiceInterceptor extends Interceptor {
  final Dio client;
  AuthService get _authService => GetIt.I.get<AuthService>();

  JmoApiServiceInterceptor({@required this.client});

  @override
  Future onError(DioError error) async {
    if (error.response?.statusCode == 401 &&
        _shouldRefreshToken(error.request?.path)) {
      Auth auth;
      try {
        auth = await _authService.refreshToken();
      } catch (e) {
        throw e;
      }

      RequestOptions request = error.response.request;
      request.headers["authorization"] = auth.authorization;
      return this.client.request(
            request.path,
            data: request.data,
            options: request,
          );
    }
    return error;
  }

  bool _shouldRefreshToken(String path) =>
      path != null && !path.startsWith('/auth');
}
