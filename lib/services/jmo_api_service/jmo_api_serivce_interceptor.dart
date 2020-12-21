import 'package:dio/dio.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:meta/meta.dart';

class JmoApiServiceInterceptor extends Interceptor {
  final Dio client;

  JmoApiServiceInterceptor({@required this.client});

  @override
  Future onError(DioError error) async {
    if (error.response?.statusCode == 401 &&
        _shouldRefreshToken(error.request?.path)) {
      try {
        await authService.setState((s) => s.refreshToken());
      } catch (e) {
        throw e;
      }

      RequestOptions request = error.response.request;
      request.headers["authorization"] = authService.state.authorization;
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
